From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 24 Nov 2016 17:12:33 +0000
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
In-Reply-To: <CAMuHMdXO=uFuJCXPjkdYB_CeyfPMqy6cMrOW=s1DZzcJ9Gp33A@mail.gmail.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
 <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
 <20161123142938.GF9057@verge.net.au>
 <HK2PR0601MB132929329C3574A0B4D9A0EAB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
 <20161124101733.GA18027@verge.net.au>
 <HK2PR0601MB1329C747CA5C6B5222C02C3FB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
 <CAMuHMdXO=uFuJCXPjkdYB_CeyfPMqy6cMrOW=s1DZzcJ9Gp33A@mail.gmail.com>
Message-ID: <HK2PR0601MB13293054589DCDED4AFC3DBFB7B60@HK2PR0601MB1329.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,

From: geert.uytterhoeven@gmail.com
Sent: 24 November 2016 16:42
> Hi Chris,
> 
> On Thu, Nov 24, 2016 at 3:25 PM, Chris Paterson
> <Chris.Paterson2@renesas.com> wrote:
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 24 November 2016 10:18
> >> On Thu, Nov 24, 2016 at 10:05:08AM +0000, Chris Paterson wrote:
> >> > From: Simon Horman [mailto:horms at verge.net.au]
> >> > > Regarding the arch/arm64/boot/dts/renesas/ portion, I would like
> >> > > some consideration given to what effect enabling memory above 4Gb
> >> > > (64bit
> >> > > addressing) would have.
> >> >
> >> > Can you give me some guidance here? I'm not sure what you're
> >> > referring to. As far as I know the DT reg definition here is
> >> > 64-bit, or are you referring to DMA usage? If the later, neither CAN
> driver uses DMA.
> >>
> >> Sorry for not being clearer.
> >>
> >> What I would like to know is if there are any problems in the CAN
> >> driver or hardware that would prevent it from functioning with memory
> >> that requires 64bit addressing present.
> >>
> >> If the CAN hardware cannot use DMA then DMA doesn't need to be
> taken
> >> into account. But if it DMA could be enabled in future for CAN, for
> >> example after some driver enhancements, then it would be good to know
> >> if 64bit memory can be supported - if not it would imply DMA cannot be
> enabled.
> >
> > Thank you for the clarification.
> >
> > The CAN interface for r8a7795/6 does not support DMA.
> >
> > With CAN FD there is currently a H/W issue that means DMA is unusable.
> 
> Is that issue present on R-Car M3-W, or only on R-Car H3 ES1.x?

Both

> 
> > Potentially this issue could be fixed in the future and DMA support
> > could be added to the driver. If this happens I can see no reason why
> > the CAN FD IP wouldn't be able to handle DMA transfers when using 64bit
> addressing.
> 
> Yep, AFAIK it uses SYS-DMAC, which supports 64-bit addressing.

Yep

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-
> m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
