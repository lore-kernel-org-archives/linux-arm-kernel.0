From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  8 Aug 2016 18:21:43 +0100
Subject: [PATCH v4 1/7] arm64: sunxi: Kconfig: add essential pinctrl driver
In-Reply-To: <20160808172149.30861-1-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
Message-ID: <20160808172149.30861-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl driver is essential for the Allwinner SoCs to work.
Add the driver's config symbol to the Kconfig entry to always compile
it in. We can't use the arm approach to make the _driver's_ Kconfig
symbol def_bool, because we lack the MACH_* symbols in arm64.
That line was in the original pinctrl driver patch, but got removed
to avoid the dependency on the Kconfig patch [1].
Also add the general PINCTRL symbol, which isn't selected automatically
for the same reason.

Reported-by: Jeroen Dekien <dekien@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/414086.html
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bb2616b..e3dc1a4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -3,6 +3,8 @@ menu "Platform selection"
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select GENERIC_IRQ_CHIP
+	select PINCTRL
+	select PINCTRL_SUN50I_A64
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.9.0
