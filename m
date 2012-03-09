From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 09:51:30 +0800
Subject: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with imx pcm and
 machine drivers
In-Reply-To: <20120308191526.GQ3852@pengutronix.de>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
 <20120308191526.GQ3852@pengutronix.de>
Message-ID: <20120309015128.GI2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 08:15:26PM +0100, Sascha Hauer wrote:
...
> > @@ -796,6 +862,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
> >  
> >  static const struct of_device_id fsl_ssi_ids[] = {
> >  	{ .compatible = "fsl,mpc8610-ssi", },
> > +	{ .compatible = "fsl,imx1-ssi", },
> 
> imx1 seems wrong here. The register layout has changed significantly between
> i.MX1 and i.MX21.
> 
Yeah, that's right.  You indeed know i.MX1 much better than me.  Will
change to:

  .compatible = "fsl,imx21-ssi"

-- 
Regards,
Shawn
