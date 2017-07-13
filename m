From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 13 Jul 2017 09:28:24 +0000
Subject: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
In-Reply-To: <20170713081213.GL5580@verge.net.au>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
 <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
 <CAMuHMdXMFkXopGiLOVf0jDDQTKig-wFrgMOKrf14341h85kPNw@mail.gmail.com>
 <20170713080228.GI5580@verge.net.au> <20170713081213.GL5580@verge.net.au>
Message-ID: <TY1PR06MB07024FD88BB0ED16E860F650B7AC0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 13 July 2017 09:12
> 
> On Thu, Jul 13, 2017 at 10:02:29AM +0200, Simon Horman wrote:
> > On Wed, Jul 12, 2017 at 01:52:49PM +0200, Geert Uytterhoeven wrote:
> > > Hi Chris,
> > >
> > > On Wed, Jul 12, 2017 at 12:03 PM, Chris Paterson
> > > <chris.paterson2@renesas.com> wrote:
> > > > Define the iwg20m board dependent part of the MMCIF0 device node.
> > > >
> > > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > > >
> > > > diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > > > b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > > > index 001ca91..ffce1b6 100644
> > > > --- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > > > +++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > >
> > > > +&pfc {
> > > > +       mmcif0_pins: mmc {
> > > > +               groups = "mmc_data8", "mmc_ctrl";
> > >
> > > "mmc_data8" is not correct, as D6/D7 of the eMMC are not connected
> > > to GP6_28 resp. GP6_29, but to GP6_6 resp. GP6_7.
> > > So it should be "mmc_data8_b".
> > >
> > > Unfortunately the latter pin group isn't supported by the PFC driver yet.
> > > Cooking a patch...

Thanks for your review Geert. Sorry I missed this.

> >
> > The above notwithstanding I have applied this patch for v4.14.
> 
> ...
> 
> Sorry, I think I need more coffee.

No worries!

> 
> I misread Geert's comment above. I have dropped this patch.
> Please post a corrected v2 of this patch.

Will do.
