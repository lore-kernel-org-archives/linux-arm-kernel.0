From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 8 Oct 2018 14:08:54 +0200
Subject: [PATCH V6 22/23] dt-bindings: mmci: add stm32 sdmmc variant
In-Reply-To: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1539000535-13261-23-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds properties for stm32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 4e69b25..6d3c626 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -16,8 +16,10 @@ Optional properties:
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
                            the ID provided by the HW
 - resets                 : phandle to internal reset line.
+			   Should be defined for sdmmc variant.
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+specific for ux500 variant:
 - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
 - st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
 - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
@@ -25,6 +27,14 @@ Optional properties:
 - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
 - st,sig-pin-fbclk       : feedback clock signal pin used.
 
+specific for sdmmc variant:
+- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
+- st,neg-edge            : data & command phase relation, generated on
+                           sd clock falling edge.
+- st,use-ckin            : use ckin pin from an external driver to sample
+                           the receive data (example: with voltage
+			   switch transceiver).
+
 Deprecated properties:
 - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
 - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
-- 
2.7.4
