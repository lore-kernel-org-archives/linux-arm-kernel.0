From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  6 Jul 2018 11:55:18 +0800
Subject: [PATCH v2 1/4] dt-bindings: k3dma: add optional property hisilicon,
 dma-min-chan
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Message-ID: <20180706035521.13736-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Yu <liyu65@hisilicon.com>

Add optional property hisilicon,dma-min-chan for k3dma.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aeac4dc4..f34202a80f3c 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -12,6 +12,11 @@ Required properties:
 		have specific request line
 - clocks: clock required
 
+Optional properties:
+- hisilicon,dma-min-chan: the minimum DMA channel number which is usable
+		Default value is 0, but in some platform it is
+		configured 1, like in hi3660 platform
+
 Example:
 
 Controller:
@@ -21,6 +26,7 @@ Controller:
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <27>;
+			hisilicon,dma-min-chan = <1>;
 			interrupts = <0 12 4>;
 			clocks = <&pclk>;
 		};
-- 
2.17.1
