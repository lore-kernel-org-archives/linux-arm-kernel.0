From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  7 Dec 2015 21:11:09 +0800
Subject: [PATCH 2/2] ARM: dts: jaq: add the power-supply for backlight and
 panel
In-Reply-To: <1449493869-32151-1-git-send-email-wxt@rock-chips.com>
References: <1449493869-32151-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1449493869-32151-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fixed regulator and reference it for the backlight and panle
power supply on rk3288 jaq board.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v1:
- Add this series patches are working with ykk'EDP patches
  on rk3288-jaq board.

 arch/arm/boot/dts/rk3288-veyron-jaq.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 991b717..9367a4c 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -123,6 +123,11 @@
 		232 233 234 235 236 237 238 239
 		240 241 242 243 244 245 246 247
 		248 249 250 251 252 253 254 255>;
+	power-supply = <&backlight_regulator>;
+};
+
+&panel {
+	power-supply = <&panel_regulator>;
 };
 
 &rk808 {
-- 
1.9.1
