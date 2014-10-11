From: dborkman@redhat.com (Daniel Borkmann)
Date: Sat, 11 Oct 2014 11:00:43 +0200
Subject: [PATCH] net: bpf: arm64: minor fix of type in jited
Message-ID: <1413018043-6329-1-git-send-email-dborkman@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 286aad3c4014 ("net: bpf: be friendly to kmemcheck") changed the
type of jited from a bitfield into a bool. As this commmit wasn't available
at the time when arm64 eBPF JIT was merged, fix it up now as net is merged
into mainline.

Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
Cc: Zi Shen Lim <zlim.lnx@gmail.com>
---
 On top of "[PATCH arm64-next v4] net: bpf: arm64: address randomize and write protect JIT code".

 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d97e729..d005f26 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -678,7 +678,7 @@ void bpf_int_jit_compile(struct bpf_prog *prog)
 
 	set_memory_ro((unsigned long)header, header->pages);
 	prog->bpf_func = (void *)ctx.image;
-	prog->jited = 1;
+	prog->jited = true;
 out:
 	kfree(ctx.offset);
 }
-- 
1.7.11.7
