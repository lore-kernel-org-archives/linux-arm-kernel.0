From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jun 2016 09:01:14 +0200
Subject: [PATCH resend v2 5/6] ARM: dts: sun9i: a80-optimus: Disable
 dummy regulators vcc3v0, vcc3v3, vcc5v0
In-Reply-To: <CAGb2v65_kAtrOW_G51Tn1urroXVuo=AqzX66zm7Ewsyw_AJdvA@mail.gmail.com>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
 <1464711804-19256-6-git-send-email-wens@csie.org>
 <20160531190113.GO4908@lukather>
 <CAGb2v65_kAtrOW_G51Tn1urroXVuo=AqzX66zm7Ewsyw_AJdvA@mail.gmail.com>
Message-ID: <20160601070114.GQ4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 10:45:51AM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 1, 2016 at 3:01 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Wed, Jun 01, 2016 at 12:23:23AM +0800, Chen-Yu Tsai wrote:
> >> These 3 regulators are provided in sunxi-common-regulators.dtsi.
> >> 3.0V/3.3V and 5.0V are commonly used voltages in Allwinner devices.
> >> These dummy regulators provide a stand-in when bindings that require
> >> one, but the real regulator is not supported yet.
> >>
> >> Since these are no longer needed, we can disable them.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun9i-a80-optimus.dts | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> >> index 6cfc02194035..991337d1d6f1 100644
> >> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
> >> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> >> @@ -322,6 +322,18 @@
> >>
> >>  #include "axp809.dtsi"
> >>
> >> +&reg_vcc3v0 {
> >> +     status = "disabled";
> >> +};
> >> +
> >> +&reg_vcc3v3 {
> >> +     status = "disabled";
> >> +};
> >> +
> >> +&reg_vcc5v0 {
> >> +     status = "disabled";
> >> +};
> >> +
> >
> > Why not remove the include entirely?
> 
> reg_usb1_vbus is still used. Or I could just copy it and
> get rid of the include.

Ah yes, it is on the Optimus (but not the cubieboard I initially
looked at).

Since we have that other regulator usb3 regulator, we can simply
remove it.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160601/80858236/attachment.sig>
