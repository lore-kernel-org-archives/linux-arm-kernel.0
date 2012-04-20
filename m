From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 20 Apr 2012 10:42:49 +0800
Subject: [PATCH 09/40] mmc sdhc i.MX: do not depend on grouped clocks
In-Reply-To: <20120420020611.GC26682@b20223-02.ap.freescale.net>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-10-git-send-email-s.hauer@pengutronix.de>
 <20120420020611.GC26682@b20223-02.ap.freescale.net>
Message-ID: <20120420024248.GA15656@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > -	clk_disable_unprepare(pltfm_host->clk);
> > -	clk_put(pltfm_host->clk);
> > +	clk_disable_unprepare(imx_data->clk_per);
> > +	clk_disable_unprepare(imx_data->clk_ipg);
> > +	clk_disable_unprepare(imx_data->clk_ahb);
> You forgot to clk_put them.
Sorry, I just realized you're using the new devm_clk_get.

Richard
