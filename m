From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 01:24:41 +0100
Subject: [PATCHv1 7/7] arm: dts: tegra: update isl29028 compatible string to
 use isil vendor prefix
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-ID: <a58c1c15cd35098fc4c69355f5fee4d3a6ae75c6.1418688043.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version).

Note: isl29028 is an I2C device so the patch does not in fact currently
depend on the introduction of "isil"-based compatible string in isl29028
driver because I2C core does not check the prefix yet.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index cbf5a1ae0ca7..a1b682ea01bd 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -189,7 +189,7 @@
 
 		/* ALS and Proximity sensor */
 		isl29028 at 44 {
-			compatible = "isl,isl29028";
+			compatible = "isil,isl29028";
 			reg = <0x44>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(L, 0) IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.1
