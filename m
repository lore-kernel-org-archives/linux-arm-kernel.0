From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 20 Jun 2016 07:49:24 +0000
Subject: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
 suspend
In-Reply-To: <5757F753.8010408@atmel.com>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-2-git-send-email-wenyou.yang@atmel.com>
 <5757EDB4.3020806@atmel.com> <5757F753.8010408@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364101650C53B8@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ferre, Nicolas
> Sent: 2016?6?8? 18:46
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>; Alan Stern
> <stern@rowland.harvard.edu>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Rob Herring <robh+dt@kernel.org>; Alexandre
> Belloni <alexandre.belloni@free-electrons.com>
> Cc: Pawel Moll <pawel.moll@arm.com>; Mark Brown <broonie@kernel.org>; Ian
> Campbell <ijc+devicetree@hellion.org.uk>; Kumar Gala <galak@codeaurora.org>;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-usb at vger.kernel.org
> Subject: Re: [PATCH v3 1/2] usb: ohci-at91: Forcibly suspend ports while USB
> suspend
> 
> Le 08/06/2016 12:04, Nicolas Ferre a ?crit :
> > Le 08/06/2016 06:15, Wenyou Yang a ?crit :
> >> In order to the save power consumption, as a workaround, suspend
> >> forcibly the USB PORTA/B/C via set the SUSPEND_A/B/C bits of OHCI
> >> Interrupt Configuration Register in the SFRs while OHCI USB suspend.
> >>
> >> This suspend operation must be done before the USB clock is disabled,
> >> resume after the USB clock is enabled.
> >>
> >> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> >
> > Little nitpicking below...
> >
> >> ---
> >>
> >> Changes in v3:
> >>  - Change the compatible description for more precise.
> >>
> >> Changes in v2:
> >>  - Add compatible to support forcibly suspend the ports.
> >>  - Add soc/at91/at91_sfr.h to accommodate the defines.
> >>  - Add error checking for .sfr_regmap.
> >>  - Remove unnecessary regmap_read() statement.
> >>
> >>  .../devicetree/bindings/usb/atmel-usb.txt          |  6 +-
> >>  drivers/usb/host/ohci-at91.c                       | 80 +++++++++++++++++++++-
> >>  include/soc/at91/at91_sfr.h                        | 29 ++++++++
> 
> Oops sorry, additional comment which is not nitpicking, this one:
> 
> We already have SFR header file in this patch:
> 
> Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Date:   Thu Mar 17 17:04:00 2016 +0100
> 
>     ARM: dts: at91: sama5d2: add SFR node
> 
>     This SFR node is looked up by the I2S controller driver to tune the
>     SFR_I2SCLKSEL register.
> 
>     Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>     Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>     Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>     Acked-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Which is already accepted by arm-soc guys for 4.7... So my ack transforms into a
> nack, sorry...
> 
> We will have to coordinate the effort and maybe take the whole series with us. But
> for sure, you'll have to use the existing include/soc/at91/atmel-sfr.h file and build
> on top of it...

Sorry, not notice this file.

I will built it on this file.

> 
> Bye,
> 
> >>  3 files changed, 112 insertions(+), 3 deletions(-)  create mode
> >> 100644 include/soc/at91/at91_sfr.h
> 
> [..]
> 
> >
> > But you can take my:
> >
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >
> > with the little corrections listed.
> >
> > Alan, We plan to take the second patch of this series with AT91 git
> > tree through arm-soc. Do you agree to take this one through yours?
> 
> Alan, forget this request, we'll have to coordinate differently.
> 
> Sorry for the noise. Bye,
> --
> Nicolas Ferre


Best Regards,
Wenyou Yang
