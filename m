From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Jun 2012 21:18:16 +0800
Subject: [PATCH] ARM: mx23: Add initial support for olinuxino board
In-Reply-To: <201206171314.09561.marex@denx.de>
References: <1339914539-4154-1-git-send-email-festevam@gmail.com>
 <201206171314.09561.marex@denx.de>
Message-ID: <20120618131814.GB19249@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 01:14:09PM +0200, Marek Vasut wrote:
> >  static const char *imx23_dt_compat[] __initdata = {
> >  	"fsl,imx23-evk",
> > +	"fsl,imx23-olinuxino",
> 
> Is this addition needed?
> 
Unlike the .of_match_table of platform_driver, I would prefer to
maintain such an explicit compatible list to show all the in-tree
boards supported by the DT_MACHINE.  Also, if we only list "fsl,imx23"
there, I'm a little worrying about people will start even dropping the
board compatible string from their board dts, then we will have no way
to play of_machine_is_compatible().

Regards,
Shawn

> >  	"fsl,imx23",
> >  	NULL,
> >  };
> 
