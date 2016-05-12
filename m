From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 12 May 2016 20:16:27 +0800
Subject: [PATCH v3 2/2] arm64: mm: Show bss segment in kernel memory layout
In-Reply-To: <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463055387-19289-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1463055387-19289-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Show the bss segment information as with text and data in Virtual
memory kernel layout.

Acked-by: James Morse <james.morse@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ce2e400..c96fe51 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -379,6 +379,8 @@ void __init mem_init(void)
 		MLK_ROUNDUP(__init_begin, __init_end));
 	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
+	pr_cont("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+		MLK_ROUNDUP(__bss_start, __bss_stop));
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
 		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
-- 
2.6.0.GIT
