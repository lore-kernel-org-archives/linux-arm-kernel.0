From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:12:55 +0800
Subject: [PATCH 02/15] dt-bindings: net: broadcom-bluetooth: Add VBAT and
 VDDIO supplies
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom Bluetooth chips have two power inputs, VBAT and VDDIO.
The former provides overall power for the chip, while the latter powers
the I/O pins and buffers.

This patch adds properties for the two so we can describe the power
supply relationships.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 2535e54219af..f6ff1a60ab3e 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -23,6 +23,8 @@ Optional properties:
    - "extclk": deprecated, replaced by "txco"
    - "lpo": external low power 32.768 kHz clock
  - clock-names: should be "extclk"
+ - vbat-supply: phandle to regulator supply for VBAT
+ - vddio-supply: phandle to regulator supply for VDDIO
 
 
 Example:
-- 
2.19.1
