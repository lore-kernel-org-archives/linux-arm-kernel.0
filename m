From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 05 Jan 2015 16:07:49 +0100
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <54AA48E6.3040404@samsung.com>
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54AA48E6.3040404@samsung.com>
Message-ID: <1420470469.15910.134.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-05 at 17:18 +0900, Joonyoung Shim wrote:
> Hi Sjoerd,
> 
> On 12/05/2014 04:27 AM, Sjoerd Simons wrote:
> > Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> > same as the vendors naming, which means it's prefixed with exynos5422
> > instead of exynos5800 as the SoC name even though it includes the
> > exyno5800 dtsi.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > Changes since v1:
> >   * Add chosen/linux,stdout-path to point the serial console device
> >   * Change memory start offset to 0x40000000 to match the vendors DTS (pointed
> >     out by Heesub Shin)
> >   * Declare base address & size for the memory banks to be used by the MFC
> > 
> > Kevin, Tyler, even though the changes are small i didn't want to just stick
> > your Tested-By on. Could you both be so kind to retest this on your XU3's ?
> > 
> > Heesub, I would still love to know the reason for having the memory start
> > address at 0x40000000 for this board?
> > 
> >  arch/arm/boot/dts/Makefile                 |   1 +
> >  arch/arm/boot/dts/exynos5422-odroidxu3.dts | 332 +++++++++++++++++++++++++++++
> >  2 files changed, 333 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu3.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 38c89ca..0a898cc 100644


> > +
> > +&hdmi {
> > +	status = "okay";
> > +	hpd-gpio = <&gpx3 7 0>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&hdmi_hpd_irq>;
> > +
> > +	vdd_osc-supply = <&ldo10_reg>;
> > +	vdd_pll-supply = <&ldo8_reg>;
> > +	vdd-supply = <&ldo8_reg>;
> 
> ldo10 and ldo8 are right? I think ldo7 and ldo6 are related with hdmi
> from schematic.

Nice catch. I followed hardkernels dts here, which refers to ldo10 &
ldo8, however double-checking the schematics indeed indicate that ldo7
and ldo6 are used the HDMI supplies. 

I'll do some testing and follow-up

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/bb87f59f/attachment-0001.bin>
