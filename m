From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Nov 2010 22:24:46 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
Message-ID: <20101129212446.GB6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 10:09:58AM -0200, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Thu, Nov 25, 2010 at 7:13 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Nov 24, 2010 at 07:42:31PM -0200, Fabio Estevam wrote:
> >> Hi Uwe,
> >>
> >> 2010/11/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> ....
> >> > I usually prefer just using DEBUG_LL and put
> >> >
> >> > ? ? ? ?#ifdef CONFIG_DEBUG_LL
> >> > ? ? ? ? ? ? ? ?void printch(char);
> >> > ? ? ? ? ? ? ? ?printch(c);
> >> > ? ? ? ?#endif
> >> >
> >> > into emit_log_char. ?But I think that's only because I don't know how to
> >> > use early printk properly. ?(You might need an additional kernel
> >> > parameter?!)
> >>
> >> Thanks. I see that the kernel crashes at sdma_get_firmware.
> >
> > This is a bug which should be fixed in this -rc cycle. Anyway, note
> > that I have a patch in my for-2.6.38 queue which makes the SDMA work
> > without a valid firmware. In this case only the scripts in ROM are used.
> 
> Yes, I am using your for-next branch, which contains the patch to make
> SDMA work without a valid firmware.
> 
> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
> tool and placed it under /lib/firmware, but the result is the same
> with or without a valid firmware: when request_firmware is called the
> following crash happens:

I tried to reproduce this today. Instead of crashing my kernel simply
hangs. This seems to be because request_firmware waits till the firmware
appears which never happens. I remember a crash like this though, I
think it has something to do with the firmware related kconfig options.
I hope to find a time slot later this week to track this down.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
