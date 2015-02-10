From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 10 Feb 2015 15:27:47 +0800
Subject: [PATCH] ARM: kprobes: Fix compilation error caused by superfluous '*'
Message-ID: <1423553267.2647.7.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a superfluous '*' in the definition of kprobe_decode_insn_t
which on older versions of GCC (4.2.4) causes the compilation error:

In file included from arch/arm/probes/kprobes/core.c:37:
arch/arm/probes/kprobes/core.h:43: error: '[*]' not allowed in other than a declaration

Fix this by removing the unneeded character.

Reported-by: Janusz U?ycki <j.uzycki@elproma.com.pl>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Russell, I also applied this to my branch that you pulled which
introduced the bug...
git://git.linaro.org/people/tixy/kernel.git kprobes

 arch/arm/probes/kprobes/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/core.h b/arch/arm/probes/kprobes/core.h
index b3036c5..ec5d1f2 100644
--- a/arch/arm/probes/kprobes/core.h
+++ b/arch/arm/probes/kprobes/core.h
@@ -40,7 +40,7 @@ typedef enum probes_insn (kprobe_decode_insn_t)(probes_opcode_t,
 						struct arch_probes_insn *,
 						bool,
 						const union decode_action *,
-						const struct decode_checker *[*]);
+						const struct decode_checker *[]);
 
 #ifdef CONFIG_THUMB2_KERNEL
 
-- 
2.1.4
