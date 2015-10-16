From: yh.huang@mediatek.com (YH Huang)
Date: Fri, 16 Oct 2015 16:50:37 +0800
Subject: [RESEND PATCH] pwm-backlight: fix the panel power sequence
In-Reply-To: <20151016083616.GA7858@pengutronix.de>
References: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
 <20151016083616.GA7858@pengutronix.de>
Message-ID: <1444985437.18373.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-10-16 at 10:36 +0200, Sascha Hauer wrote:
> On Fri, Oct 16, 2015 at 09:37:34AM +0800, YH Huang wrote:
> > In order to match the panel power sequence, disable the enable_gpio
> > in the probe function. Also, reorder the code in the power_on and
> > power_off function to match the timing.
> > @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	pb->dev = &pdev->dev;
> >  	pb->enabled = false;
> >  
> > -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> > +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
> 
> Please actually test your patches. This change here won't compile.
> 
> Sascha
> 

I will send patch v2 to fix it.

YH Huang
