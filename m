From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 09:34:06 +0800
Subject: mxs: enable phy-clock in the driver?
In-Reply-To: <20120108144558.GB2544@pengutronix.de>
References: <20120108144558.GB2544@pengutronix.de>
Message-ID: <20120109013404.GD1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 03:45:58PM +0100, Wolfram Sang wrote:
> Hi Shawn,
> 
> I recently noticed that my tx28 board did not have net when booting from NAND
> (before that, barebox was setting up the network). Adding lines like these from
> mx28evk helped:
> 
> 228         /* Enable fec phy clock */
> 229         clk = clk_get_sys("pll2", NULL);
> 230         if (!IS_ERR(clk))
> 231                 clk_enable(clk);
> 
> So, if every board seems to need this, I'd think this should rather be in the
> driver? Am I correct or is there something I have overlooked?
> 
Hmm, as far as I know, at least m28evk from denx does not need this.
Different from that imx28 supplies clock to phy on mx28evk board,
m28evk has phy supply clock to imx28. 

-- 
Regards,
Shawn
