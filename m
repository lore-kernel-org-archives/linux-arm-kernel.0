From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 28 Apr 2017 14:58:42 +0200
Subject: [PATCH v2 3/5] arm64: dts: r8a7796: Add placeholders for various
 devices
In-Reply-To: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
References: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1493384324-29344-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add empty device nodes serving as placeholders for devices that are not
yet supported and/or tested on R-Car M3-W, but are supported and used on
Salvator-X or H3ULCB boards equipped with an R-Car H3 SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC state.
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 8e2aab8b6b103cc9..60a4289d0b14fe50 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -961,6 +961,38 @@
 			dma-channels = <16>;
 		};
 
+		hsusb: usb at e6590000 {
+			/* placeholder */
+		};
+
+		xhci0: usb at ee000000 {
+			/* placeholder */
+		};
+
+		ohci0: usb at ee080000 {
+			/* placeholder */
+		};
+
+		ehci0: usb at ee080100 {
+			/* placeholder */
+		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			/* placeholder */
+		};
+
+		ohci1: usb at ee0a0000 {
+			/* placeholder */
+		};
+
+		ehci1: usb at ee0a0100 {
+			/* placeholder */
+		};
+
+		usb2_phy1: usb-phy at ee0a0200 {
+			/* placeholder */
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7796";
 			reg = <0 0xee100000 0 0x2000>;
@@ -1063,5 +1095,55 @@
 				};
 			};
 		};
+
+		rcar_sound: sound at ec500000 {
+			/* placeholder */
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+				};
+
+				dvc1: dvc-1 {
+				};
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+				};
+				src1: src-1 {
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+				};
+
+				ssi1: ssi-1 {
+				};
+			};
+		};
+
+		pciec0: pcie at fe000000 {
+			/* placeholder */
+		};
+
+		pciec1: pcie at ee800000 {
+			/* placeholder */
+		};
+
+		du: display at feb00000 {
+			/* placeholder */
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.7.4
