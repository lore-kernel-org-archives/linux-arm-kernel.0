From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 29 Mar 2012 16:11:00 +0530
Subject: [PATCH V3 2/7] SPEAr3xx: Add clock instance of usb hosts - ehci and
 ohci 0 and 1
In-Reply-To: <cover.1333017183.git.viresh.kumar@st.com>
References: <cover.1333017183.git.viresh.kumar@st.com>
Message-ID: <4874b04e10d82eca2c48ce7a4ad69954532e55a3.1333017183.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds following clocks: "usbh.0_clk" and "usbh.1_clk". They are used
by ehci and ohci drivers for SPEAr3xx usb host devices.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 6b2cd9b..47d4535 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -412,6 +412,21 @@ static struct clk usbd_clk = {
 	.recalc = &follow_parent,
 };
 
+/* clock derived from usbh clk */
+/* usbh0 clock */
+static struct clk usbh0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &usbh_clk,
+	.recalc = &follow_parent,
+};
+
+/* usbh1 clock */
+static struct clk usbh1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &usbh_clk,
+	.recalc = &follow_parent,
+};
+
 /* clock derived from ahb clk */
 /* apb masks structure */
 static struct bus_clk_masks apb_masks = {
@@ -679,6 +694,9 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll3 clk */
 	CLKDEV_INIT("designware_udc", NULL, &usbd_clk),
 	CLKDEV_INIT(NULL, "usbh_clk", &usbh_clk),
+	/* clock derived from usbh clk */
+	CLKDEV_INIT(NULL, "usbh.0_clk", &usbh0_clk),
+	CLKDEV_INIT(NULL, "usbh.1_clk", &usbh1_clk),
 	/* clock derived from ahb clk */
 	CLKDEV_INIT(NULL, "apb_clk", &apb_clk),
 	CLKDEV_INIT("i2c_designware.0", NULL, &i2c_clk),
-- 
1.7.9
