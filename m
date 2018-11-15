From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 17:35:50 +0800
Subject: [PATCH v2 02/15] dt-bindings: net: broadcom-bluetooth: Add VBAT and
 VDDIO supplies
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
Message-ID: <20181115093603.26729-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Bluetooth chips have two power inputs, VBAT and VDDIO.
The former provides overall power for the chip, while the latter powers
the I/O pins and buffers.

This patch adds properties for the two so we can describe the power
supply relationships.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 711c75ac2bb5..78cfa0fbece9 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -23,6 +23,8 @@ Optional properties:
    - "extclk": deprecated, replaced by "txco"
    - "txco": external reference clock (not a standalone crystal)
    - "lpo": external low power 32.768 kHz clock
+ - vbat-supply: phandle to regulator supply for VBAT
+ - vddio-supply: phandle to regulator supply for VDDIO
 
 
 Example:
-- 
2.19.1
