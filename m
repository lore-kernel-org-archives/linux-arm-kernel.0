From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 22:36:54 +0200
Subject: [PATCH] ARM: dt: sun8i-h3: Add sunxi-sid to dts for sun8i-h3
In-Reply-To: <20161019074016.GA31440@Red>
References: <1475660904-7959-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161005122130.8cc229ff5d4990149956b49c@free.fr>
 <20161019074016.GA31440@Red>
Message-ID: <20161020203654.2erph2mr73yzksla@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 09:40:16AM +0200, LABBE Corentin wrote:
> On Wed, Oct 05, 2016 at 12:21:30PM +0200, Jean-Francois Moine wrote:
> > On Wed,  5 Oct 2016 11:48:24 +0200
> > Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> > 
> > > This patch add support for the sunxi-sid driver to the device tree for sun8i-h3.
> > > 
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > index 9f58bb4..abfd29c 100644
> > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > @@ -211,6 +211,11 @@
> > >  			#size-cells = <0>;
> > >  		};
> > >  
> > > +		sid: eeprom at 01c14200 {
> > > +			compatible = "allwinner,sun7i-a20-sid";
> > > +			reg = <0x01c14200 0x200>;
> > 
> > The datasheet says 1Kb starting at 0x01c14000.
> > Is there any reason to reduce the area and to shift the offset?
> > 
> 
> According to http://linux-sunxi.org/SID_Register_Guide "For
> Allwinner A83T and H3 the SID address space starts at 0x01c14000,
> and the e-fuses are at offset 0x200".
>
> So I use this offset, since the sunxi_sid driver need the base
> address of e-fuses.
> 
> The easiest solution is to use 0x01c14200 since the other part of
> sid is not used and not known (A83T/H3 user manual doesnt give any
> information on all sid space, worse for A64 which reference SID only
> in memory map).
> 
> So probably for H3/A64/A83T, there will never any usage of the rest
> of the SID address space.

And since we can't know that, and we have to maintain the DT ABI,
using the whole address map and an offset, with a new compatible, is
definetely the safest thing to do.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/dec6def5/attachment.sig>
