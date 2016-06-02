From: hdegoede@redhat.com (Hans de Goede)
Date: Thu,  2 Jun 2016 19:18:55 +0200
Subject: [PATCH v2 3/4] mfd: axp20x: Add axp20x-usb-power-supply for axp22x
 pmics
In-Reply-To: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1464887936-17020-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add axp20x-usb-power-supply for axp22x pmics.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Change compatible string for axp22x usb-power-supply cell to match v2 of:
 "power: axp20x_usb: Add support for usb power-supply on axp22x pmics"
---
 drivers/mfd/axp20x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index ca04361..6364dab 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -160,6 +160,11 @@ static struct resource axp20x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
 };
 
+static struct resource axp22x_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+};
+
 static struct resource axp22x_pek_resources[] = {
 	{
 		.name   = "PEK_DBR",
@@ -527,6 +532,11 @@ static struct mfd_cell axp22x_cells[] = {
 		.resources		= axp22x_pek_resources,
 	}, {
 		.name			= "axp20x-regulator",
+	}, {
+		.name		= "axp20x-usb-power-supply",
+		.of_compatible	= "x-powers,axp221-usb-power-supply",
+		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
+		.resources	= axp22x_usb_power_supply_resources,
 	},
 };
 
-- 
2.7.4
