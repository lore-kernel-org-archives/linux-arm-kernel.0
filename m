From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 14 Mar 2012 11:19:28 +0100
Subject: [PATCH v3 0/5] ARM: Initial support for Cortex-M3
Message-ID: <20120314101928.GA29474@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is the result of reworking Catalin's exception handling patch to
stick to the current pt_regs layout. I extended it by two words to save
the exception return value. (The 2nd word is unused and only to maintain
stack alignment.)

Other than that only minor cleanups were done (some of them were
suggested by Catalin in reply to my v2 series).

These patches are available at

	git://git.pengutronix.de/git/ukl/linux.git cortexm3-for-rmk

basing on 3.3-rc7. There are some bits missing to allow a Cortex-M3 to
boot. They are contained in the branch efm32 in the same repository
together with support for the efm32 SoC if you're interested.
The most important parts missing (apart from SoC specific stuff) are
interrupt support and Makefile/Kconfig glue.

I'd be happy if these patches made it into 3.4-rc1. Any constructive
feedback welcome.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
