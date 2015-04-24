From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 24 Apr 2015 15:32:28 -0400
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to
 the WDT driver.
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
Message-ID: <CAJhHMCAz3ichPmTvdeXx+6+JK7uNvfyh4m4_Jg8mFYi5ZcHRNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 3:08 PM, Eric Anholt <eric@anholt.net> wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog at vger.kernel.org


Any reason not to select BCM2835_WDT in the config by default then?

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 8b11f44..dd4856d 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -116,6 +116,7 @@ config ARCH_BCM2835
        select CLKSRC_OF
        select PINCTRL
        select PINCTRL_BCM2835
+       select BCM2835_WDT
        help
          This enables support for the Broadcom BCM2835 SoC. This SoC is
          used in the Raspberry Pi and Roku 2 devices.



-- 
Pranith
