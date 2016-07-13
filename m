From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Jul 2016 08:25:21 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <CAOMZO5B4CUr_-U3s+fo-O_BcREWQijffXFeRmUPiwDWdhY07pQ@mail.gmail.com>
References: <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
 <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
 <20160712191541.GY16643@pengutronix.de>
 <CAOMZO5C3eQFfs=ZS5nfDw6XnEAgfcc_+W2n0y8Xd-zsTfd-+gA@mail.gmail.com>
 <CAOMZO5B4CUr_-U3s+fo-O_BcREWQijffXFeRmUPiwDWdhY07pQ@mail.gmail.com>
Message-ID: <20160713062521.GZ16643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Tue, Jul 12, 2016 at 05:40:13PM -0300, Fabio Estevam wrote:
> On Tue, Jul 12, 2016 at 5:30 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Tue, Jul 12, 2016 at 4:15 PM, Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> >
> >>> @@ -244,7 +244,7 @@
> >>>                       fsl,pins = <
> >>>                               MX25_PAD_UART1_RTS__UART1_RTS           0xe0
> >>>                               MX25_PAD_UART1_CTS__UART1_CTS           0xe0
> >>> -                             MX25_PAD_UART1_TXD__UART1_TXD           0x80000000
> >>> +                             MX25_PAD_UART1_TXD__UART1_TXD           0x00
> >>>                               MX25_PAD_UART1_RXD__UART1_RXD           0xc0
> >>
> >> Are you sure here? According to the reference manual bit 0x40 of
> >> IOMUXC_SW_PAD_CTL_PAD_UART1_RXD isn't valid. And my i.mx25 based machine
> >> agrees:
> >>
> >>         barebox at imx25:/ mw 0x43fac368 0xc0
> >>         barebox at imx25:/ md 0x43fac368+4
> >>         43fac368: 00000080
> >
> > Let me double check it when I get access to this board again.
> 
> Sorry, I misread.
> 
> You were referring to MX25_PAD_UART1_RXD__UART1_RXD, not
> MX25_PAD_UART1_TXD__UART1_TXD.
> 
> I didn't touch MX25_PAD_UART1_RXD__UART1_RXD, so your series does the
> right thing for this pad (put it at 0x80).

OK.

Which U-Boot did you test? Mainline or the vendor variant?

Can you provide the output of

	md 0x43fac000+0x584

in U-Boot (which for sure has a different syntax that I don't know) and
from Linux

	memtool md 0x43fac000+0x584

(or whatever different tool you prefer to do the same).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
