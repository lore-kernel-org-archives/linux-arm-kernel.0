From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Dec 2012 08:55:56 +0000
Subject: [PATCH 07/12] ARM: ux500: Specify the ux5x0 MMCI regulator's on/off
 GPIO as high-enable
In-Reply-To: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355129761-8088-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If not specified, the GPIO control bit is inverted by default i.e.
low-enable and high-disable. This is not the case with the MMCI
regulator, hence it will turn on during a disable and off when
regulator_enable() is invoked.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index bbea89a..0523681 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -638,6 +638,8 @@
 			regulator-name = "mmci-reg";
 			regulator-type = "voltage";
 
+			enable-active-high;
+
 			states = <1800000 0x1
 				  3300000 0x0>;
 
-- 
1.7.9.5
