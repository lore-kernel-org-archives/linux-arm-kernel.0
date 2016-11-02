From: clg@kaod.org (=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=)
Date: Wed,  2 Nov 2016 08:57:04 +0100
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to 'aspeed,
 ast2400-ibt-bmc'
In-Reply-To: <1478073426-3714-1-git-send-email-clg@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
Message-ID: <1478073426-3714-2-git-send-email-clg@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed SoCs have two BT interfaces : one is IPMI compliant and the
other is H8S/2168 compliant.

The current ipmi/bt-bmc driver implements the IPMI version and we
should reflect its nature in the compatible node name using
'aspeed,ast2400-ibt-bmc' instead of 'aspeed,ast2400-bt-bmc'. The
latter should be used for a H8S interface driver if it is implemented
one day.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt}    | 4 ++--
 drivers/char/ipmi/bt-bmc.c                                            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} (85%)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
similarity index 85%
rename from Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
rename to Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
index fbbacd958240..6f28969af9dc 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-bt-bmc.txt
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-ibt-bmc.txt
@@ -6,7 +6,7 @@ perform in-band IPMI communication with their host.
 
 Required properties:
 
-- compatible : should be "aspeed,ast2400-bt-bmc"
+- compatible : should be "aspeed,ast2400-ibt-bmc"
 - reg: physical address and size of the registers
 
 Optional properties:
@@ -17,7 +17,7 @@ Optional properties:
 Example:
 
 	ibt at 1e789140 {
-		compatible = "aspeed,ast2400-bt-bmc";
+		compatible = "aspeed,ast2400-ibt-bmc";
 		reg = <0x1e789140 0x18>;
 		interrupts = <8>;
 	};
diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index b49e61320952..fc9e8891eae3 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -484,7 +484,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id bt_bmc_match[] = {
-	{ .compatible = "aspeed,ast2400-bt-bmc" },
+	{ .compatible = "aspeed,ast2400-ibt-bmc" },
 	{ },
 };
 
@@ -502,4 +502,4 @@ module_platform_driver(bt_bmc_driver);
 MODULE_DEVICE_TABLE(of, bt_bmc_match);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alistair Popple <alistair@popple.id.au>");
-MODULE_DESCRIPTION("Linux device interface to the BT interface");
+MODULE_DESCRIPTION("Linux device interface to the IPMI BT interface");
-- 
2.7.4
