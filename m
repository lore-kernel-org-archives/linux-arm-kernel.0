From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Jun 2013 12:39:36 -0300
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <CAOMZO5DN6u32Udz9SxgnmpH8gtM0FzbL1fPCZ96EchSUzbBzMQ@mail.gmail.com>
References: <51A5A808.2070803@digi.com> <201306221529.53043.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFB072@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306241551.19831.marex@denx.de>
 <CAOMZO5DN6u32Udz9SxgnmpH8gtM0FzbL1fPCZ96EchSUzbBzMQ@mail.gmail.com>
Message-ID: <CAOMZO5DFdUNm3e6+VLioFLEORYXaN2X331jOYBm7o-pE_6MYvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:23 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 24, 2013 at 10:51 AM, Marek Vasut <marex@denx.de> wrote:
>
>> Fabio, can you possibly test on MX23EVK please?
>
> I never used USB gadget with chipidea driver.
>
> Could you please explain what are the changes I need to do in the dts
> file (I want to try on mx28evk first) and defconfig in order to be
> able to test gadget? I am running today's linux-next.

I tried the following:

--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -239,7 +239,7 @@

        ahb at 80080000 {
                usb0: usb at 80080000 {
-                       vbus-supply = <&reg_usb0_vbus>;
+                       dr_mode = "peripheral";
                        status = "okay";
                };

,but I get:

[    1.495725] usbcore: registered new interface driver asix
[    1.501516] usbcore: registered new interface driver ax88179_178a
[    1.508139] usbcore: registered new interface driver cdc_ether
[    1.514463] usbcore: registered new interface driver smsc95xx
[    1.520743] usbcore: registered new interface driver net1080
[    1.526920] usbcore: registered new interface driver cdc_subset
[    1.533254] usbcore: registered new interface driver zaurus
[    1.539587] usbcore: registered new interface driver cdc_ncm
[    1.545432] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.552494] usbcore: registered new interface driver usb-storage
[    1.565640] ci_hdrc ci_hdrc.0: can't start gadget role
[    1.577682] ci_hdrc ci_hdrc.1: can't start gadget role
[    1.588304] ci_hdrc ci_hdrc.2: can't start gadget role
[    1.598888] ci_hdrc ci_hdrc.3: can't start gadget role
[    1.609508] ci_hdrc ci_hdrc.4: can't start gadget role
[    1.620144] ci_hdrc ci_hdrc.5: can't start gadget role
[    1.631028] ci_hdrc ci_hdrc.6: can't start gadget role
[    1.642563] ci_hdrc ci_hdrc.7: can't start gadget role
[    1.653530] ci_hdrc ci_hdrc.8: can't start gadget role
[    1.664744] ci_hdrc ci_hdrc.9: can't start gadget role
[    1.676085] ci_hdrc ci_hdrc.10: can't start gadget role
[    1.687121] ci_hdrc ci_hdrc.11: can't start gadget role
[    1.698309] ci_hdrc ci_hdrc.12: can't start gadget role
[    1.709442] ci_hdrc ci_hdrc.13: can't start gadget role
[    1.720879] ci_hdrc ci_hdrc.14: can't start gadget role
[    1.732216] ci_hdrc ci_hdrc.15: can't start gadget role
[    1.743660] ci_hdrc ci_hdrc.16: can't start gadget role
[    1.755289] ci_hdrc ci_hdrc.17: can't start gadget role
[    1.766821] ci_hdrc ci_hdrc.18: can't start gadget role
[    1.778642] ci_hdrc ci_hdrc.19: can't start gadget role
[    1.790227] ci_hdrc ci_hdrc.20: can't start gadget role
[    1.802036] ci_hdrc ci_hdrc.21: can't start gadget role
[    1.813879] ci_hdrc ci_hdrc.22: can't start gadget role
[    1.825921] ci_hdrc ci_hdrc.23: can't start gadget role

... and system hangs here.

Any suggestions as to how to get gadget working?
