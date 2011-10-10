From: Barry.Song@csr.com (Barry Song)
Date: Mon, 10 Oct 2011 02:50:54 -0700
Subject: [PATCH] ARM: CSR: PM: use outer_resume to resume L2 cache
Message-ID: <1318240254-13872-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

now we move l2x0 resume to Linux from bootloader since l2x0 already has
resume support in core.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 This patch depends on Barry Song's
 ARM: cache-l2x0: add resume entry for l2 in secure mode
 http://www.spinics.net/lists/arm-kernel/msg142696.html
 which has been in rmk's tree

 arch/arm/mach-prima2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
index 0ba39f3..cb53160 100644
--- a/arch/arm/mach-prima2/pm.c
+++ b/arch/arm/mach-prima2/pm.c
@@ -71,6 +71,7 @@ static int sirfsoc_pm_enter(suspend_state_t state)
 		outer_disable();
 		/* go zzz */
 		cpu_suspend(0, sirfsoc_finish_suspend);
+		outer_resume();
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
