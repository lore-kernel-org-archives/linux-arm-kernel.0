From: opendmb@gmail.com (Doug Berger)
Date: Tue, 28 Mar 2017 14:34:31 -0700
Subject: [PATCH v2 8/8] bus: brcmstb_gisb: update to support new revision
In-Reply-To: <20170328213431.10904-1-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
Message-ID: <20170328213431.10904-9-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 7278 introduces a new version of this core.  This
commit adds support for that revision.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt |  3 ++-
 drivers/bus/brcmstb_gisb.c                              | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
index 1eceefb20f01..8a6c3c2e58fe 100644
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
@@ -3,7 +3,8 @@ Broadcom GISB bus Arbiter controller
 Required properties:
 
 - compatible:
-    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for 28nm chips
+    "brcm,bcm7278-gisb-arb" for V7 28nm chips
+    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
     "brcm,bcm7435-gisb-arb" for newer 40nm chips
     "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
     "brcm,bcm7038-gisb-arb" for 130nm chips
diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 774729002b8c..6c3b0dda75f2 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -65,6 +65,15 @@ static const int gisb_offsets_bcm7038[] = {
 	[ARB_ERR_CAP_MASTER]	= -1,
 };
 
+static const int gisb_offsets_bcm7278[] = {
+	[ARB_TIMER]		= 0x008,
+	[ARB_ERR_CAP_CLR]	= 0x7f8,
+	[ARB_ERR_CAP_HI_ADDR]	= -1,
+	[ARB_ERR_CAP_ADDR]	= 0x7e0,
+	[ARB_ERR_CAP_STATUS]	= 0x7f0,
+	[ARB_ERR_CAP_MASTER]	= 0x7f4,
+};
+
 static const int gisb_offsets_bcm7400[] = {
 	[ARB_TIMER]		= 0x00c,
 	[ARB_ERR_CAP_CLR]	= 0x0c8,
@@ -328,6 +337,7 @@ static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 	{ .compatible = "brcm,bcm7445-gisb-arb", .data = gisb_offsets_bcm7445 },
 	{ .compatible = "brcm,bcm7435-gisb-arb", .data = gisb_offsets_bcm7435 },
 	{ .compatible = "brcm,bcm7400-gisb-arb", .data = gisb_offsets_bcm7400 },
+	{ .compatible = "brcm,bcm7278-gisb-arb", .data = gisb_offsets_bcm7278 },
 	{ .compatible = "brcm,bcm7038-gisb-arb", .data = gisb_offsets_bcm7038 },
 	{ },
 };
-- 
2.12.0
