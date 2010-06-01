From: jason77.wang@gmail.com (Jason Wang)
Date: Tue,  1 Jun 2010 23:10:43 +0800
Subject: [PATCH 3/3] mx51/clock: add keypad clock definition and registration
In-Reply-To: <1275405043-18230-3-git-send-email-jason77.wang@gmail.com>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-3-git-send-email-jason77.wang@gmail.com>
Message-ID: <1275405043-18230-4-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX51 platforms, the keypad controller has no gate clock, to
meet the imx keypad driver requirement, we add a empty definition and
register it. Now the keypad driver can work.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index d9f612d..e89b93a 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -758,6 +758,10 @@ static struct clk gpt_32k_clk = {
 	.parent = &ckil_clk,
 };
 
+static struct clk kpp_clk = {
+	.id = 0,
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -821,6 +825,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
+	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.5.6.5
