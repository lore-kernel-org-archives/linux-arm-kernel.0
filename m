From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 29 May 2018 17:05:57 +0200
Subject: [PATCH v3 6/8] dt-bindings: rcar-vin: Add 'hsync-as-de' custom prop
In-Reply-To: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1527606359-19261-7-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the boolean custom property 'renesas,hsync-as-de' that indicates
that the HSYNC signal is internally used as data-enable, when the
CLKENB signal is not connected.

As this is a VIN specificity create a custom property specific to the R-Car
VIN driver.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
v3:
- new patch
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index ff53226..024c109 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -60,6 +60,9 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
         - vsync-active: see [1] for description. Default is active high.
         - data-enable-active: polarity of CLKENB signal, see [1] for
           description. Default is active high.
+        - renesas,hsync-as-de: a boolean property to indicate that HSYNC signal
+          is internally used as data-enable when the CLKENB signal is
+          not available.

         If both HSYNC and VSYNC polarities are not specified, embedded
         synchronization is selected.
--
2.7.4
