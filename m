From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Oct 2009 10:01:28 +0200
Subject: Ext3 is supported not well at 2.6.28 for external SD card removal
In-Reply-To: <4ADC1943.1090306@gmail.com>
References: <4ADBFB5B.9030200@gmail.com>
	<200910190759.11591.marek.vasut@gmail.com>
	<4ADC1943.1090306@gmail.com>
Message-ID: <20091019080128.GC11449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Oct 19, 2009 at 03:46:11PM +0800, Peter Chen wrote:
> Marek Vasut wrote:
>> Dne Po 19. ??jna 2009 07:38:35 Peter Chen napsal(a):
>> You popped the card out without unmounting the filesystem I guess ?
> We don't execute umount at 2.6.27/23 either, and it has little error:
> [   32.541208] Buffer I/O error on device mmcblk1p1, logical block 0
> [   32.544784] lost page write due to I/O error on mmcblk1p1
>
> Besides, the remove card is ok after suspend at 2.6.27 and 2.6.23.
>
> Usually, the remove card(ext3) without umount is forbiddon or not?
You shouldn't remove the card without unmounting first.  And you should
unmount with .23 and .27, too.  Just because these kernels don't wail it
doesn't mean you cannot loose data.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
