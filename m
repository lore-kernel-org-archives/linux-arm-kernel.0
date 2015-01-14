From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 20:46:35 +0100
Subject: [PATCH] ARM: dts: sun6i: Convert hummingbird a31 dts to label
 references
In-Reply-To: <54B6421C.3030303@redhat.com>
References: <1421123484-21387-1-git-send-email-wens@csie.org>
 <20150113154415.GY4891@lukather>
 <CAGb2v67sQyNcFQgvm60TUzjp3QBusckvP2i_xkj-eLRZubkALA@mail.gmail.com>
 <20150113162053.GZ4891@lukather> <54B61AD3.2040407@redhat.com>
 <CAGb2v65jZZJoG3z+9Vc460X3kvogwLDze_Jx4pS-xuR=84GBVQ@mail.gmail.com>
 <54B62CC8.5010403@redhat.com>
 <CAGb2v65pFDWnucdP-_fX+JzdWSx9maWCkzc_z1jFcnt=GMxfqA@mail.gmail.com>
 <54B6421C.3030303@redhat.com>
Message-ID: <20150114194635.GF4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 11:17:00AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 14-01-15 10:29, Chen-Yu Tsai wrote:
> >On Wed, Jan 14, 2015 at 4:46 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>Hi,
> >>
> >>
> >>On 14-01-15 09:41, Chen-Yu Tsai wrote:
> >>>
> >>>On Wed, Jan 14, 2015 at 3:29 PM, Hans de Goede <hdegoede@redhat.com>
> >>>wrote:
> >>>>
> >>>>Hi,
> >>>>
> >>>>
> >>>>On 13-01-15 17:20, Maxime Ripard wrote:
> >>>>>
> >>>>>
> >>>>>On Tue, Jan 13, 2015 at 11:54:21PM +0800, Chen-Yu Tsai wrote:
> >>>>>>
> >>>>>>
> >>>>>>On Tue, Jan 13, 2015 at 11:44 PM, Maxime Ripard
> >>>>>><maxime.ripard@free-electrons.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>Hi,
> >>>>>>>
> >>>>>>>On Tue, Jan 13, 2015 at 12:31:24PM +0800, Chen-Yu Tsai wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>Using label references is preferred when override settings from the
> >>>>>>>>included dtsi.
> >>>>>>>>
> >>>>>>>>Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>>>>>>>---
> >>>>>>>>
> >>>>>>>>My AXP221 series touches this file. I thought I'd convert it first.
> >>>>>>>>
> >>>>>>>>This looks like a lot of changes. But if you filter out all the
> >>>>>>>>indentation changes, it's just the opening lines for each node.
> >>>>>>>>
> >>>>>>>>---
> >>>>>>>>    arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 181
> >>>>>>>>++++++++++++++--------------
> >>>>>>>>    1 file changed, 88 insertions(+), 93 deletions(-)
> >>>>>>>>
> >>>>>>>>diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >>>>>>>>b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >>>>>>>>index ebd5f7854b1b..97dbaeb76416 100644
> >>>>>>>>--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >>>>>>>>+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >>>>>>>>@@ -61,101 +61,96 @@
> >>>>>>>>         chosen {
> >>>>>>>>                 bootargs = "earlyprintk console=ttyS0,115200";
> >>>>>>>>         };
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&mmc0 {
> >>>>>>>>+     pinctrl-names = "default";
> >>>>>>>>+     pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
> >>>>>>>>+     vmmc-supply = <&reg_vcc3v0>;
> >>>>>>>>+     bus-width = <4>;
> >>>>>>>>+     cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
> >>>>>>>>+     cd-inverted;
> >>>>>>>>+     status = "okay";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&usbphy {
> >>>>>>>>+     usb1_vbus-supply = <&reg_usb1_vbus>;
> >>>>>>>>+     status = "okay";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&ehci0 {
> >>>>>>>>+     status = "okay";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&ohci0 {
> >>>>>>>>+     status = "okay";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&pio {
> >>>>>>>>+     mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
> >>>>>>>>+             allwinner,pins = "PA8";
> >>>>>>>>+             allwinner,function = "gpio_in";
> >>>>>>>>+             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>>>>>>>+             allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> >>>>>>>>+     };
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&mmc0_pins_a {
> >>>>>>>>+     /* external pull-ups missing for some pins */
> >>>>>>>>+     allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&usb1_vbus_pin_a {
> >>>>>>>>+     /* different pin from sunxi-common-regulators */
> >>>>>>>>+     allwinner,pins = "PH24";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&uart0 {
> >>>>>>>>+     pinctrl-names = "default";
> >>>>>>>>+     pinctrl-0 = <&uart0_pins_a>;
> >>>>>>>>+     status = "okay";
> >>>>>>>>+};
> >>>>>>>>+
> >>>>>>>>+&i2c0 {
> >>>>>>>>+     pinctrl-names = "default";
> >>>>>>>>+     pinctrl-0 = <&i2c0_pins_a>;
> >>>>>>>>+     /* pull-ups and devices require AXP221 DLDO3 */
> >>>>>>>>+     status = "failed";
> >>>>>>>>+};
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>I think we should define a convention about how to sort these nodes
> >>>>>>>before we actually start merging some of it.
> >>>>>>>
> >>>>>>>This of course also apply to the other patches doing that, hence why
> >>>>>>>Hans is CC'd.
> >>>>>>>
> >>>>>>>I guess sorting them by label alphabetical order would make
> >>>>>>>sense. What do you think?
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>I'm currently using the ordering from the dtsi, which is based
> >>>>>>on address. Even if it's not visible, if you're creating the
> >>>>>>dts by looking at the dtsi and enabling the devices available,
> >>>>>>that's the order you add them by, so it kind of makes sense.
> >>>>
> >>>>
> >>>>
> >>>>Right, that is what I'm doing too.
> >>>>
> >>>>>I know you're doing just that, and that it makes some kind of sense
> >>>>>whenever you convert an old DTS to the label based syntax, but
> >>>>>whenever you create a new one, it's a bit harder to get it right.
> >>>>>
> >>>>>And the fact that Hans didn't follow that convention illustrate that
> >>>>>very well.
> >>>>
> >>>>
> >>>>
> >>>>Erm, that is not true, I did follow that convention as my 2 new
> >>>>dts files started in the old format too, and I simply re-indented
> >>>>most nodes.
> >>>
> >>>
> >>>I think it also makes sense for new boards as well. One would look
> >>>at the dtsi to know what devices on the soc are available, and
> >>>copy the ones that can be used.
> >>>
> >>>But the ordering does make adding new devices with new drivers
> >>>a bit problematic. It is easy to place new nodes in the wrong
> >>>place.
> >>>
> >>>>>I guess a sorting logic internal to the DTS itself would be much
> >>>>>easier to understand and follow, hence why I suggested the
> >>>>>alphabetical order: it just stands out without any external reference.
> >>>>
> >>>>
> >>>>
> >>>>If we agree on this, we also need to think about what to do with new
> >>>>board specific powersupplies, as those need to be in the root node,
> >>>>if you look at the bananapro dts from the v2 patch you will see what
> >>>>I mean.
> >>>
> >>>
> >>>How about the root node at the top? With the board description, chosen,
> >>>aliases (if any), and then the _new_ regulators (sorted by name)?
> >>>
> >>>One can then easily identify which are board specific, and which are
> >>>more or less generic.
> >>
> >>
> >>Sure, that works for me, what about the leds section, also in the
> >>root node at the top? Before or after regulators ?
> >
> >Before the regulators? Because a) L comes before R and  b) this
> >is what's currently done in our dts files.
> 
> OK, Maxime, do you agree ?

See, we're getting to the alphabetical order :)

I don't what your workflow is, but usually I start from a close DTS,
never from a DTSI.

We will indeed still have the root node with the leds, regulators,
buttons, any board-specific platform driver actually. It indeed makes
sense to place that on top.

And if we're going to have an alphabetical order within that node,
won't it be weird if we have what looks like a random one below?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/66ee3ec4/attachment.sig>
