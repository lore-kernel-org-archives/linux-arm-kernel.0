From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Nov 2015 07:38:09 +0100
Subject: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
In-Reply-To: <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
Message-ID: <20151124063808.GB32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 11:13:13AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
> >> Add a node describing the Security ID memory to the
> >> Allwinner H3 .dtsi file.
> >>
> >> Signed-off-by: Josef Gajdusek <atx@atx.name>
> >> ---
> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> index 0faa38a..58de718 100644
> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> @@ -359,6 +359,13 @@
> >>                       #size-cells = <0>;
> >>               };
> >>
> >> +             sid: eeprom at 01c14000 {
> >> +                     compatible = "allwinner,sun4i-a10-sid";
> >> +                     reg = <0x01c14000 0x400>;
> >
> > The datasheet says it's 256 bytes wide, while the size here is of 1kB,
> > is it intentional?
> 
> My H3 datasheet (v1.1) says its 1 kB wide.

Is it? in the Security ID section, it is said to be 2kb == 256B wide.

> It'd be nice if Allwinner actually listed the "usable" E-fuse
> offsets and widths, instead of having us dig through the SDK code.

Yep.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/915bc4aa/attachment.sig>
