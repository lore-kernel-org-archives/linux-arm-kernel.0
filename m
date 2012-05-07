From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 7 May 2012 08:46:46 +0800
Subject: [PATCH 2/5] net: fec: adopt pinctrl API
In-Reply-To: <201205061026.29238.sfking@fdwdc.com>
References: <1336309094-18517-1-git-send-email-shawn.guo@linaro.org>
 <1336309094-18517-3-git-send-email-shawn.guo@linaro.org>
 <201205061026.29238.sfking@fdwdc.com>
Message-ID: <20120507004644.GE19389@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 10:26:28AM -0700, Steven King wrote:
> > +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> > +	if (IS_ERR(pinctrl)) {
> > +		ret = PTR_ERR(pinctrl);
> > +		goto failed_pin;
> > +	}
> 
> What happens here if pinmux support isnt implemented yet as is the case for 
> m68k/coldfire?

There are a set of stub functions defined for !CONFIG_PINCTRL
in include/linux/pinctrl/consumer.h to ensure the pinctrl calls
succeed for those cases.

-- 
Regards,
Shawn
