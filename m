From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Nov 2012 22:43:24 +0800
Subject: [PATCH 3/3] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the
 device tree
In-Reply-To: <50AB8A98.1060601@free-electrons.com>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1352394113-19513-4-git-send-email-maxime.ripard@free-electrons.com>
 <20121120132546.GA4882@S2100-06.ap.freescale.net>
 <50AB8A98.1060601@free-electrons.com>
Message-ID: <20121120144322.GE4882@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:50:16PM +0100, Maxime Ripard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Shawn,
> 
> Le 20/11/2012 14:25, Shawn Guo a ?crit :
> > On Thu, Nov 08, 2012 at 06:01:53PM +0100, Maxime Ripard wrote:
> >> Add the GPIO expander found on the i2c1 bus, behind the muxer to
> >> the device tree.
> >> 
> >> This gpio expander will be used to get tachymeters values and
> >> data ready interruptions from the nuvoton NAU7802 ADCs.
> >> 
> >> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com> 
> >> --- arch/arm/boot/dts/imx28-cfa10049.dts |   26
> >> +++++++++++++++++++++++++- 1 file changed, 25 insertions(+), 1
> >> deletion(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts
> >> b/arch/arm/boot/dts/imx28-cfa10049.dts index bdc80a4..714953b
> >> 100644 --- a/arch/arm/boot/dts/imx28-cfa10049.dts +++
> >> b/arch/arm/boot/dts/imx28-cfa10049.dts @@ -22,8 +22,9 @@ 
> >> apb at 80000000 { apbh at 80000000 { pinctrl at 80018000 { -
> >> pinctrl-names = "default", "default"; +				pinctrl-names =
> >> "default", "default", "default"; pinctrl-1 =
> >> <&hog_pins_cfa10049>; +				pinctrl-2 =
> >> <&hog_pins_cfa10049_pullup>;
> > 
> > I do not think it necessarily needs to be multiple pinctrl states. 
> > Something like the following should just work?
> > 
> > pinctrl-names = "default"; pinctrl-0 = <&hog_pins_cfa10049 
> > &hog_pins_cfa10049_pullup>;
> 
> Actually, pinctrl-0 is already used by the cfa-10036, and putting also
> the group hog_pins_cfa10036 in here would lead to duplication and
> confusion imho, thus why I used two different states at first.
> 
Ah, yes, I forgot the fact that imx28-cfa10049.dts includes
imx28-cfa10036.dts.

> Moreover, the cfa-10036 being able to run without any expansion board,
> we need to be able to have a different muxing for both.
> 
> Apart from that, I guess we could extend the pintctrl-1 property
> already here to add the _pullup group.
> 
Right.

Shawn
