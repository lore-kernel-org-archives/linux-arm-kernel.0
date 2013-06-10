From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 10 Jun 2013 15:11:12 -0700
Subject: [PATCH -v11 resend 10/11] arm, change reboot_mode to use enum
 reboot_mode
In-Reply-To: <1370519244-49918-11-git-send-email-holt@sgi.com>
References: <1370519244-49918-1-git-send-email-holt@sgi.com>
 <1370519244-49918-11-git-send-email-holt@sgi.com>
Message-ID: <20130610151112.26c71baa4127ed931d913215@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  6 Jun 2013 06:47:23 -0500 Robin Holt <holt@sgi.com> wrote:

> Preparing to move the parsing of reboot= to generic kernel code
> forces the change in reboot_mode handling to use the enum.
> 
> ...
>
>  125 files changed, 282 insertions(+), 166 deletions(-)

That's a big patch.  The potential for ARM breakage is high.  I spotted
one glitch:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: arm-change-reboot_mode-to-use-enum-reboot_mode-fix

fix arch/arm/mach-socfpga/socfpga.c

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russ Anderson <rja@sgi.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-socfpga/socfpga.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm/mach-socfpga/socfpga.c~arm-change-reboot_mode-to-use-enum-reboot_mode-fix arch/arm/mach-socfpga/socfpga.c
--- a/arch/arm/mach-socfpga/socfpga.c~arm-change-reboot_mode-to-use-enum-reboot_mode-fix
+++ a/arch/arm/mach-socfpga/socfpga.c
@@ -97,7 +97,7 @@ static void socfpga_cyclone5_restart(enu
 
 	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 
-	if (mode == 'h')
+	if (mode == REBOOT_HARD)
 		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
 	else
 		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
_
