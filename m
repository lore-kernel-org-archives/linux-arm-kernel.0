From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Sep 2011 14:36:35 +0200
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <20110912114932.GH1258@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
	<20110912094634.GP31404@pengutronix.de>
	<20110912114932.GH1258@S2100-06.ap.freescale.net>
Message-ID: <20110912123635.GK28624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Sep 12, 2011 at 07:49:33PM +0800, Shawn Guo wrote:
> On Mon, Sep 12, 2011 at 11:46:34AM +0200, Sascha Hauer wrote:
> > On Tue, Sep 06, 2011 at 05:58:37PM +0800, Shawn Guo wrote:
> > > +static int __init imx_src_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
> > > +	src_base = of_iomap(np, 0);
> > > +	WARN_ON(!src_base);
> > > +
> > > +	return 0;
> > > +}
> > > +early_initcall(imx_src_init);
> > 
> > What I'm concerned about is that we carefully removed all assumptions
> > about which SoC the code runs on in the past. Now with this patchset
> > many of them come back. Here we have a initcall without any check
> > whether we really run on i.MX6.
> 
> The "check" has been done on Kconfig level as below.
> 
> config SOC_IMX6Q
>         bool "i.MX6 Quad support"
>         select HAVE_IMX_SRC
> 
> obj-$(CONFIG_HAVE_IMX_SRC) += src.o
Think multi-SoC-kernel that has SOC_IMX6Q and say SOC_IMX51.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
