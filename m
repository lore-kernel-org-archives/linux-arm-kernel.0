From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 May 2012 16:50:03 +0800
Subject: [PATCH 3/5] ARM: imx: add audio codec clk lookup for imx53-qsb
In-Reply-To: <20120514082201.GF21318@pengutronix.de>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-4-git-send-email-shawn.guo@linaro.org>
 <20120514082201.GF21318@pengutronix.de>
Message-ID: <20120514085002.GE20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 10:22:01AM +0200, Sascha Hauer wrote:
> >  static void __init imx53_dt_init(void)
> >  {
> >  	struct device_node *node;
> > @@ -99,6 +115,9 @@ static void __init imx53_dt_init(void)
> >  		of_node_put(node);
> >  	}
> >  
> > +	if (of_machine_is_compatible("fsl,imx53-qsb"))
> > +		imx53_qsb_init();
> > +
> 
> I wonder if we really want to open this can of worms here. Adding board
> specific hacks (or fixups) in this file can become very messy once we
> have more than only a few oftree based boards.
> 
>From what I have seen, this is an acceptable solution to board specific
setup.  What's the alternative on your mind?

-- 
Regards,
Shawn
