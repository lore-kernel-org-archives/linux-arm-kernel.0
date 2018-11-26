From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:43 +0100
Subject: [PATCH 17/40] arm64: dts: renesas: salvator-common: add companion
 property in usb3_peri0
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <396aadeb951dfb11c075ac6ed18178fa8513e746.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a property "companion" with xhci0 phandle to
the usb3_peri0 node in salvator-common.dtsi.

About the detail of this property for renesas_usb3 udc driver, please
refer to the commit 39facfa01c9f ("usb: gadget: udc: renesas_usb3:
Add register of usb role switch").

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 054a7eeeef92..a3e89504e044 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -817,6 +817,8 @@
 	phys = <&usb3_phy0>;
 	phy-names = "usb";
 
+	companion = <&xhci0>;
+
 	status = "okay";
 };
 
-- 
2.11.0
