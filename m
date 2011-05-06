From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 May 2011 00:25:23 -0700
Subject: [PATCH] omap: fix build when MTD_NAND_OMAP2 and
	TOUCHSCREEN_ADS7846 are disabled
In-Reply-To: <53A11D3C-4DBA-4772-AF14-3590772F6AA1@linuxhacker.ru>
References: <1304515622-25113-1-git-send-email-mike@compulab.co.il>
	<53A11D3C-4DBA-4772-AF14-3590772F6AA1@linuxhacker.ru>
Message-ID: <20110506072523.GA25670@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Oleg Drokin <green@linuxhacker.ru> [110504 08:59]:
> Hello!
> 
> On May 4, 2011, at 9:27 AM, Mike Rapoport wrote:
> 
> > Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
> > NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
> > (omap: consolidate touch screen initialization among different boards)
> > break compilation when CONFIG_MTD_NAND_OMAP2 and
> > CONFIG_TOUCHSCREEN_ADS7846 are not selected.
> > Removing ifdefs and stubs from common-board-devices.h fixes the problem.
> 
> Works for me.

We should not build in code unnecessarily unless the boards has
ads7847. Many boards don't have it.

So how about do the ifdef optimization for ads7846_spi_board_info
and omap_ads7846_init in common-board-devices.c?

That keeps the header clean and the we have all the code in one
place in a way where it's optimized out if not selected.

Regards,

Tony
