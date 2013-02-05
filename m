From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Feb 2013 13:54:57 +0800
Subject: [PATCH v4] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130205055456.GA6234@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 02:24:26PM +0100, Sascha Hauer wrote:
> 4th round of patches.
> 
> Peter, I would be glad if you could test them before your holiday. I rebased
> your last round of Chipidea OTG patches onto this series which you can pull
> here:
> 
> git://git.pengutronix.de/git/imx/linux-2.6.git tags/usb-chipidea-otg-for-next
> 
> I couldn't really test the otg patches since my current hardware does not have
> the ID pin connected, but I can verify that my usecase still works with your
> patches applied.

Sascha, I have tested your patchset, it works after adding a few of changes
at my otg patchset (we still need to read otgsc for gadget-only function).
I use my mx6q sabrelite board to test.

I have tested all roles with below diff:
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 49527d7..cdbf2ec 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -72,6 +72,10 @@
 				pinctrl-0 = <&pinctrl_usbotg_1>;
 				disable-over-current;
 				otg_id_pin_select_change;
+				/* dr_mode = "peripheral"; */
+				/* dr_mode = "host"; */
+				dr_mode = "otg";
+				phy_type = "utmi_wide";
 				status = "okay";
 			};

So, feel free to add my Tested-by: Peter Chen <peter.chen@freescale.com>

Besides, if you have a mx51 bbg board, you can test id-switch function.
For mx5x, you may need a phy driver.

My git: https://github.com/hzpeterchen/linux-usb.git master

It is based on your tag, and add latest otg patch.
Besides, it has Michael Grzeschik/Marc Kleine-Budde
usb misc patch as well as my platform changes for mx6q board.

> 
> Alex, should the patches work for you and are fine otherwise, could you apply
> them for v3.9?
> 
> Sascha
> 
> 
-- 

Best Regards,
Peter Chen
