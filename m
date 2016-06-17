From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 17 Jun 2016 13:44:22 +0000
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <20160608203810.GF2466@piout.net>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <20160608202651.GA23604@rob-hp-laptop> <20160608203810.GF2466@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A24364101650C3632@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2016?6?9? 4:38
> To: Rob Herring <robh@kernel.org>
> Cc: Yang, Wenyou <Wenyou.Yang@atmel.com>; Alan Stern
> <stern@rowland.harvard.edu>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Ferre, Nicolas <Nicolas.FERRE@atmel.com>;
> Pawel Moll <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-usb at vger.kernel.org
> Subject: Re: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
> suspend
> 
> On 08/06/2016 at 15:26:51 -0500, Rob Herring wrote :
> > On Wed, Jun 08, 2016 at 12:15:10PM +0800, Wenyou Yang wrote:
> > > In order to the save power consumption, as a workaround, suspend
> > > forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> > > Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> > >
> > > This suspend operation must be done before the USB clock is
> > > disabled, resume after the USB clock is enabled.
> > >
> > > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > > ---
> > >
> > > Changes in v3:
> > >  - Change the compatible description for more precise.
> > >
> > > Changes in v2:
> > >  - Add compatible to support forcibly suspend the ports.
> > >  - Add soc/at91/at91_sfr.h to accommodate the defines.
> > >  - Add error checking for .sfr_regmap.
> > >  - Remove unnecessary regmap_read() statement.
> > >
> > >  .../devicetree/bindings/usb/atmel-usb.txt          |  6 +-
> > >  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
> > >  include/soc/at91/at91_sfr.h                        | 29 ++++++++
> > >  3 files changed, 112 insertions(+), 3 deletions(-)  create mode
> > > 100644 include/soc/at91/at91_sfr.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > > b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > > index 5883b73..888deaa 100644
> > > --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > > +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> > > @@ -3,8 +3,10 @@ Atmel SOC USB controllers  OHCI
> > >
> > >  Required properties:
> > > - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> > > -   used in host mode.
> > > + - compatible: Should be one of the following
> > > +	       "atmel,at91rm9200-ohci" for USB controllers used in host mode.
> > > +	       "atmel,sama5d2-ohci" for USB controllers used in host mode
> > > +	       on SAMA5D2 which can force to suspend.
> >
> > Guess I wasn't clear enough before. Drop "which can force to suspend".
> >
> 
> Well, my point is that we don't need a new compatible anyway.

Could you give some advice?.

> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com


Best Regards,
Wenyou Yang
