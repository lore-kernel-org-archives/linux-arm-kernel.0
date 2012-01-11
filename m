From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 11 Jan 2012 11:59:46 +0100
Subject: mxs: enable phy-clock in the driver?
In-Reply-To: <20120108144558.GB2544@pengutronix.de>
References: <20120108144558.GB2544@pengutronix.de>
Message-ID: <201201111159.46678.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Shawn,
> 
> I recently noticed that my tx28 board did not have net when booting from
> NAND (before that, barebox was setting up the network). Adding lines like
> these from mx28evk helped:
> 
> 228         /* Enable fec phy clock */
> 229         clk = clk_get_sys("pll2", NULL);
> 230         if (!IS_ERR(clk))
> 231                 clk_enable(clk);
> 
> So, if every board seems to need this, I'd think this should rather be in
> the driver? Am I correct or is there something I have overlooked?
> 
> Regards,
> 
>    Wolfram

Did you really disable the clock to FEC or only the PHY didn't have clock?

M
