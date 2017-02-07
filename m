From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Tue,  7 Feb 2017 11:02:50 +0800
Subject: [PATCH v2 2/3] dt: ASoC: zx-i2s: Document for the ZTE zx296718 I2S
 controller
In-Reply-To: <1486436571-8682-1-git-send-email-baoyou.xie@linaro.org>
References: <1486436571-8682-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486436571-8682-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents the devicetree for the ZTE's zx296718
I2S audio controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..c405561 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -1,10 +1,12 @@
 ZTE ZX296702 I2S controller
 
 Required properties:
- - compatible : Must be "zte,zx296702-i2s"
+ - compatible : Should include one of the following strings:
+	"zte,zx296702-i2s","zte,zx296718-i2s".
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "tx" for the wclk, "pclk" for the pclk to the I2S interface.
+	must contain pclk for zx296718 SoC.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
-- 
2.7.4
