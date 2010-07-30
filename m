From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Jul 2010 22:57:56 +0200
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <1280518523-5526-1-git-send-email-rabin@rab.in>
References: <1280518523-5526-1-git-send-email-rabin@rab.in>
Message-ID: <20100730205756.GA28316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 01:05:23AM +0530, Rabin Vincent wrote:
> "ARM: Auto calculate ZRELADDR and provide option for exceptions" broke the
> Thumb-2 decompressor because it removed an entry in the LC0 table but didn't
> adjust the offset the Thumb-2 code uses to load the SP from that table.
> 
> Fix it, and also change the ARM code to use the separate SP-load since
> ARM instructions that include the SP in the LDM register list are
> deprecated.
I only found:

	LDM{<cond>}<addressing_mode> <Rn>{!}, <registers>
	...
	If the base register <Rn> is specified in <registers>, and base
	register write-back is specified,
	the final value of <Rn> is UNPREDICTABLE.

Are you really sure about this?  Where do you know it from?
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
