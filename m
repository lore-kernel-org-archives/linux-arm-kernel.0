From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Wed, 6 Mar 2013 12:42:09 +0100
Subject: [PATCH] ASoC: samsung: let device core setup the default pin
 configuration
In-Reply-To: <20130306113741.GA19556@opensource.wolfsonmicro.com>
References: <1362570951-14403-1-git-send-email-thomas.abraham@linaro.org>
 <20130306113741.GA19556@opensource.wolfsonmicro.com>
Message-ID: <201303061242.09978.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 6. M?rz 2013, 12:37:43 schrieb Mark Brown:
> On Wed, Mar 06, 2013 at 05:25:51PM +0530, Thomas Abraham wrote:
> > With device core now able to setup the default pin configuration,
> > the pin configuration code based on the deprecated Samsung specific
> > gpio bindings in i2s driver is removed.
> 
> There's rather a lot of non-DT Samsung platforms...

I think the real non-dt platforms won't be affected.

+       if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+               dev_err(&pdev->dev, "Unable to configure gpio\n");
+               ret = -EINVAL;
+               goto err;

is still there for them.

What is going away is the deprecated non-pinctrl way to setup the pins on dt 
platforms.
