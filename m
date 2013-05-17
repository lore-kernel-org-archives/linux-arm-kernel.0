From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 21:54:46 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <4003326.AbobOukrYT@wuerfel>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <201305171429.52646.arnd@arndb.de>
 <20130517130603.GJ8607@S2101-09.ap.freescale.net>
 <4003326.AbobOukrYT@wuerfel>
Message-ID: <20130517135444.GK8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 03:17:31PM +0200, Arnd Bergmann wrote:
> Can't we move the driver to drivers/clk and have it initialized through
> of_clk_init() without representing all clocks in the DT?
> 
> For all I can tell, CLK_OF_DECLARE() requires only the clock provider
> to be described in DT, but not the actual clocks.

Clock provider is actually a "clk".  For fixed rate clock example,
of_fixed_factor_clk_setup() firstly parses DT to get all the
necessary data and then calls clk_register_fixed_factor() to register
the clk to framework, lastly calls of_clk_add_provider() to register the
clk as a provider.

Shawn
