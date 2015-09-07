From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 07 Sep 2015 11:18:25 +0200
Subject: [PATCH v2 2/8] clk: imx25: retain early UART clocks during
 kernel init
In-Reply-To: <20150907091005.GV9999@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
 <1441382419-4343-3-git-send-email-l.stach@pengutronix.de>
 <20150906142315.GA30746@tiger> <20150907091005.GV9999@pengutronix.de>
Message-ID: <1441617505.28391.8.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 07.09.2015, 11:10 +0200 schrieb Uwe Kleine-K?nig:
> On Sun, Sep 06, 2015 at 10:23:15PM +0800, Shawn Guo wrote:
> > 
> > I prefer to code it like:
> > 
> > static struct clk **uart_clks[] __initdata = {
> > 	&clk[uart_ipg_per],
> > 	&clk[uart1_ipg],
> > 	&clk[uart2_ipg],
> > 	&clk[uart3_ipg],
> > 	&clk[uart4_ipg],
> > 	&clk[uart5_ipg],
> > 	NULL
> > };
> 
> And maybe also use mx25_ as prefix to make the name unique.
> 
We already have a lot of non-unique names in those files. As this is a
static variable it will not leak into other compilation units, so I
prefer to keep the current style of the file.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
