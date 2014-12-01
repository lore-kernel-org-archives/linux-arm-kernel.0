From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 1 Dec 2014 11:06:10 +1100
Subject: linux-next: manual merge of the samsung tree with the  tree
Message-ID: <20141201110610.2126988c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm64/Kconfig between commit 419043609689 ("arm64: amd-seattle:
Adding device tree for AMD Seattle platform") from the arm-soc tree and
commit ab93f6ca6394 ("arm64: Enable ARMv8 based exynos7 SoC support")
from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm64/Kconfig
index 44cb996e3cd7,7351199f0a42..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -142,11 -142,23 +142,28 @@@ source "kernel/Kconfig.freezer
  
  menu "Platform selection"
  
 +config ARCH_SEATTLE
 +	bool "AMD Seattle SoC Family"
 +	help
 +	  This enables support for AMD Seattle SOC Family
 +
+ config ARCH_EXYNOS
+ 	bool
+ 	help
+ 	  This enables support for Samsung Exynos SoC family
+ 
+ config ARCH_EXYNOS7
+ 	bool "ARMv8 based Samsung Exynos7"
+ 	select ARCH_EXYNOS
+ 	select COMMON_CLK_SAMSUNG
+ 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+ 	select HAVE_S3C_RTC if RTC_CLASS
+ 	select PINCTRL
+ 	select PINCTRL_EXYNOS
+ 
+ 	help
+ 	  This enables support for Samsung Exynos7 SoC family
+ 
  config ARCH_THUNDER
  	bool "Cavium Inc. Thunder SoC Family"
  	help
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/ab859110/attachment.sig>
