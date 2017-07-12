From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 12 Jul 2017 14:29:29 +0800
Subject: [PATCH 3/4] arm64: dts: rockchip: enable the GPU for RK3399-GRU
In-Reply-To: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
References: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1499840971-20392-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the gpu and adds the mali-supply power for RK3399-GRU
devices.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 90259cf..d48e98b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -595,6 +595,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&ppvar_gpu>;
+	status = "okay";
+};
+
 ap_i2c_mic: &i2c1 {
 	status = "okay";
 
-- 
2.7.4
