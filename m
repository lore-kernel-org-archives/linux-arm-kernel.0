From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jul 2016 17:30:31 -0300
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <20160712191541.GY16643@pengutronix.de>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
 <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
 <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
 <20160712191541.GY16643@pengutronix.de>
Message-ID: <CAOMZO5C3eQFfs=ZS5nfDw6XnEAgfcc_+W2n0y8Xd-zsTfd-+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Jul 12, 2016 at 4:15 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>> @@ -244,7 +244,7 @@
>>                       fsl,pins = <
>>                               MX25_PAD_UART1_RTS__UART1_RTS           0xe0
>>                               MX25_PAD_UART1_CTS__UART1_CTS           0xe0
>> -                             MX25_PAD_UART1_TXD__UART1_TXD           0x80000000
>> +                             MX25_PAD_UART1_TXD__UART1_TXD           0x00
>>                               MX25_PAD_UART1_RXD__UART1_RXD           0xc0
>
> Are you sure here? According to the reference manual bit 0x40 of
> IOMUXC_SW_PAD_CTL_PAD_UART1_RXD isn't valid. And my i.mx25 based machine
> agrees:
>
>         barebox at imx25:/ mw 0x43fac368 0xc0
>         barebox at imx25:/ md 0x43fac368+4
>         43fac368: 00000080

Let me double check it when I get access to this board again.
                                           ....
>
> (This entry was fixed in my series to 0x80.) So you only checked the
> NO_PAD_CTL values, right?

Yes, I only checked the NO_PAD_CTL values.
