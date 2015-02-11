From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 11 Feb 2015 16:06:42 +0100
Subject: [PATCH v4 10/11] ARM: tegra: Set nvidia,
 reset-gpio property on the PMC node
In-Reply-To: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1423667220-1062-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1423667220-1062-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Nyan boards, we need to reset the TPM on reboot. This is
accomplished by asserting the GPIO I5.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 9b3fca8..b8936a0 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -358,6 +358,7 @@
 		nvidia,core-pwr-off-time = <61036>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+		nvidia,reset-gpio = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 	};
 
 	hda at 0,70030000 {
-- 
1.9.3
