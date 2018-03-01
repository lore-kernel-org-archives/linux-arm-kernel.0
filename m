From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Thu,  1 Mar 2018 16:25:12 +0100
Subject: [PATCH v2 3/6] arm64: dts: rockchip: enable typec-phy for
 rk3399-sapphire.
In-Reply-To: <20180301152515.20940-1-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
Message-ID: <20180301152515.20940-4-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
support for rk3399") caused a regression regarding the USB3 type-A port.
During boot, the following message appears a few times:

  dwc3: failed to initialize core

The driver is deferred waiting for the typec-phy, but this never happens
bceause is disabled. So, enable it.

Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index ce592a4c0c4c..9c685eab4748 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -557,6 +557,14 @@
 	status = "okay";
 };
 
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
 &u2phy0 {
 	status = "okay";
 
-- 
2.16.1
