From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 14:50:19 +0200
Subject: [PATCH v3 9/9] arm64: dts: add Pine64 support
In-Reply-To: <7483f6ea-3b59-46ca-fb31-f26af6ec8423@arm.com>
References: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
 <20161003080913.24197-10-maxime.ripard@free-electrons.com>
 <7483f6ea-3b59-46ca-fb31-f26af6ec8423@arm.com>
Message-ID: <20161011125019.GY3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 11:24:24AM +0100, Andre Przywara wrote:
> Hi Maxime,
> 
> thanks for the respin!
> 
> On 03/10/16 09:09, Maxime Ripard wrote:
> > From: Andre Przywara <andre.przywara@arm.com>
> > 
> > The Pine64 is a cost-efficient development board based on the
> > Allwinner A64 SoC.
> > There are three models: the basic version with Fast Ethernet and
> > 512 MB of DRAM (Pine64) and two Pine64+ versions, which both
> > feature Gigabit Ethernet and additional connectors for touchscreens
> > and a camera. Or as my son put it: "Those are smaller and these are
> > missing." ;-)
> > The two Pine64+ models just differ in the amount of DRAM
> > (1GB vs. 2GB). Since U-Boot will figure out the right size for us and
> > patches the DT accordingly we just need to provide one DT for the
> > Pine64+.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > [Maxime: Removed the common DTSI and include directly the pine64 DTS]
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/Makefile                       |  1 +
> >  arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
> >  .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 50 +++++++++++
> >  .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 74 +++++++++++++++++
> >  include/dt-bindings/reset/sun50i-a64-ccu.h         | 97 +++++++++++-----------
> 
> Shouldn't the changes in this file be merged into patch 6/9?

Oops, yeah, of course.

> > diff --git a/include/dt-bindings/reset/sun50i-a64-ccu.h b/include/dt-bindings/reset/sun50i-a64-ccu.h
> > index e61fac294d73..db60b29ddb11 100644
> > --- a/include/dt-bindings/reset/sun50i-a64-ccu.h
> > +++ b/include/dt-bindings/reset/sun50i-a64-ccu.h
> > @@ -46,52 +46,53 @@
> >  #define RST_USB_PHY0		0
> >  #define RST_USB_PHY1		1
> >  #define RST_USB_HSIC		2
> > -#define RST_MBUS		3
> ....
> > +#define RST_DRAM		3
> > +#define RST_MBUS		4
> 
> So I take it that this kind of changes will not happen anymore once the
> DT has been merged?
> And this numbering is arbitrary and not connected to some hardware
> bits/register addresses at all?
> And in case we find some missing bits later we will just queue them at
> the end?

Your constant reminding of that on all the patches is getting
old. Yes, this is what we agreed on two releases ago. And since
there's already some very real bugs that can't be fixed because of
that, there's really nothing to be proud of.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/c48fcec8/attachment.sig>
