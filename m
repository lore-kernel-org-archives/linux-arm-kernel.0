From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 30 Jan 2014 08:10:19 +0900
Subject: [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
In-Reply-To: <20140129230959.22655.55645.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
Message-ID: <20140129231019.22655.41456.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Create a new group for the USB0 OVC/VBUS pin by itself. This
allows us to monitor PWEN as GPIO on the Lager board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7790.c	2014-01-24 10:23:32.000000000 +0900
@@ -3231,6 +3231,13 @@ static const unsigned int usb0_pins[] =
 static const unsigned int usb0_mux[] = {
 	USB0_PWEN_MARK, USB0_OVC_VBUS_MARK,
 };
+static const unsigned int usb0_ovc_vbus_pins[] = {
+	/* OVC/VBUS */
+	RCAR_GP_PIN(5, 19),
+};
+static const unsigned int usb0_ovc_vbus_mux[] = {
+	USB0_OVC_VBUS_MARK,
+};
 /* - USB1 ------------------------------------------------------------------- */
 static const unsigned int usb1_pins[] = {
 	/* PWEN, OVC */
@@ -3789,6 +3796,7 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(tpu0_to2),
 	SH_PFC_PIN_GROUP(tpu0_to3),
 	SH_PFC_PIN_GROUP(usb0),
+	SH_PFC_PIN_GROUP(usb0_ovc_vbus),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb2),
 	VIN_DATA_PIN_GROUP(vin0_data, 24),
@@ -4134,6 +4142,7 @@ static const char * const tpu0_groups[]
 
 static const char * const usb0_groups[] = {
 	"usb0",
+	"usb0_ovc_vbus",
 };
 
 static const char * const usb1_groups[] = {
