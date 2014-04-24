From: pavel@denx.de (Pavel Machek)
Date: Thu, 24 Apr 2014 17:21:33 +0200
Subject: [PATCH] clk: socfpga: fix clock driver for 3.15
In-Reply-To: <1397481336-5592-1-git-send-email-dinguyen@altera.com>
References: <1397481336-5592-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140424152133.GA23032@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> commit [1771b10d6 clk: respect the clock dependencies in of_clk_init]
> exposed a flaw in the socfpga clock driver and prevents the platform
> from booting on 3.15-rc1.
> 
> Because the "altr,clk-mgr" is not really a clock, it should not be using
> CLK_OF_DECLARE, instead we should be mapping the clk-mgr's base address
> one of the functional clock init function. Use the socfpga_pll_init function
> to map the clk_mgr_base_addr as this clock should always be initialized first.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Works for me, thanks!
									Pavel

Tested-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
