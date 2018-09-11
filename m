From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 11 Sep 2018 08:00:31 +0530
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Enable SD card detection for
 Rock960 boards
In-Reply-To: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
References: <20180911023031.4892-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180911023031.4892-5-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For proper working of SD cards, let's add the Card Detect GPIO property
to the common devicetree for Rock960 family boards.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index 5a5d8e28ef55..f68254831ad9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -403,6 +403,7 @@
 	cap-sd-highspeed;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <100000 100000000>;
+	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	sd-uhs-sdr104;
 	vqmmc-supply = <&vcc_sd>;
-- 
2.17.1
