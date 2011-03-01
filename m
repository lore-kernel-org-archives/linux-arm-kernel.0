From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Mar 2011 21:30:18 +0100
Subject: [PATCH 0/2] 3 build failures in imx-for-2.6.39
Message-ID: <20110301203018.GY22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

currently there are 3 build failures in Sascha's imx-for-2.6.39 branch.
Two of them are fixed in this series, I didn't find motivation to fix
the third (in mx51_defconfig):

	arch/arm/mach-mx5/built-in.o: In function `efika_board_common_init':
	board-mx51_efikamx.c:(.init.text+0x1384): undefined reference to `otg_ulpi_create'
	board-mx51_efikamx.c:(.init.text+0x1430): undefined reference to `mxc_ulpi_access_ops'

I guess there are some #ifdefs missing somewhere.

I talked shortly to Sascha about it and we both think that these #ifdefs
are ugly and a better fix is needed here. (E.g. providing dummys for
the used functions. But I didn't look into that yet.)

For the two patches in this series I'd suggest to squash them in the
offending commits, but that's up to Sascha to decide.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
