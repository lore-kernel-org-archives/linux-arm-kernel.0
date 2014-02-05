From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Feb 2014 11:32:18 +0100
Subject: [PATCH v3 8/8] ARM: dts: sun7i: Add ethernet alias for GMAC
In-Reply-To: <CAGb2v659T_QTLChB0NRS0seQvwDBCmTAH6UBEghZng9Ac6uL4g@mail.gmail.com>
References: <1391398346-5094-1-git-send-email-wens@csie.org>
 <1391398346-5094-9-git-send-email-wens@csie.org>
 <20140203193802.GE25625@lukather>
 <CAGb2v659T_QTLChB0NRS0seQvwDBCmTAH6UBEghZng9Ac6uL4g@mail.gmail.com>
Message-ID: <20140205103218.GB3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 12:43:18PM +0800, Chen-Yu Tsai wrote:
> On Tue, Feb 4, 2014 at 3:38 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Feb 03, 2014 at 11:32:26AM +0800, Chen-Yu Tsai wrote:
> >> U-Boot will insert MAC address into the device tree image.
> >> It looks up ethernet[0-5] aliases to find the ethernet nodes.
> >> Alias GMAC as ethernet0, as it is the only ethernet controller used.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> index 65fb8d0..c48fb11 100644
> >> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> >> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> >> @@ -17,7 +17,7 @@
> >>       interrupt-parent = <&gic>;
> >>
> >>       aliases {
> >> -             ethernet0 = &emac;
> >> +             ethernet0 = &gmac;
> >>       };
> >
> > I'm not very fond of this patch.
> >
> > People might rely on the fact that ethernet0 is actually the emac, and
> > are expecting u-boot to fill the ethaddr variable to the emac, and not
> > the gmac.
> >
> > Since u-boot is totally able to deal with several ethernet addresses,
> > please add it as ethernet1.
> 
> Actually I think we should override this in the board dts.
> The boards we currently support can only use emac or gmac,
> and in our u-boot tree, they have been converted to using
> gmac. If any future boards support both emac and gmac, we
> can address the ordering then. And the ordering should
> match u-boot.
> 
> What do you think?

That what u-boot does is not a good argument (especially when it's not
even mainline u-boot we're talking about). Otherwise, I can just cook
up a bootloader of my own, do crazy stuff in it, and use that as an
argument to get crazy things in the kernel.

And you can set eth1addr just fine in u-boot.

But thinking a bit more about your patch, I guess that this patch
makes some kind of sense anyway..

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/c90dca1e/attachment-0001.sig>
