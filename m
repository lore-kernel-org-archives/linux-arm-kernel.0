From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 22:33:33 +0200
Subject: Help in running top of git on Freescale MX28 EVK board
In-Reply-To: <CAOdLEaqXWnrwePZ1RjCM_AR2YYxtrTQh5u1nGDejt9-PMQO_9g@mail.gmail.com>
References: <CAOdLEaq2_EcK+UKtbGQjCCCXm09Yc9T9SrG_XLj8KOsUODpLRw@mail.gmail.com>
	<CAOdLEaqXWnrwePZ1RjCM_AR2YYxtrTQh5u1nGDejt9-PMQO_9g@mail.gmail.com>
Message-ID: <20110906203333.GR28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sam,

On Tue, Sep 06, 2011 at 12:58:37PM -0700, Sam Gandhi wrote:
> Replying to this thread in case someone else has similar issue.
> 
> Problem turned out to be name of the console. When using top of the
> git tree one has to provide console=ttyAMA0,115200. When using
> freescale's 2.6.35 kernel console had to be console=ttyAM0,115200
<praise>Thanks to ukleinek in #armlinux for the right guess</praise> :-)

> Out of curiosity how does one go about finding such device name
> changes looking at the git commit log or Documentation ?
I knew it because I remembered when Shawn (from Freescale) tried to
mainline their serial driver and Wolfram (from Pengutronix) pointed out
that the IP is actually an amba pl011.

If you know that (or you see that CONFIG_SERIAL_AMBA_PL011=y in
arch/arm/configs/mxs_defconfig) it's just a matter of

	$ grep \\.name drivers/tty/serial/amba-pl011.c

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
