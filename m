From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Feb 2014 08:26:57 +0000
Subject: [PATCH 07/12] mfd: syscon: Consider platform data a regmap
 config name
In-Reply-To: <1392188982.914924525@f237.i.mail.ru>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-8-git-send-email-pawel.moll@arm.com>
 <1392188982.914924525@f237.i.mail.ru>
Message-ID: <20140212082657.GK15081@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Use the device platform data as a regmap config
> > name. This is particularly useful in the regmap
> > debugfs when there is more than one syscon device
> > registered, to distinguish the register blocks.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> ...
> > syscon_regmap_config.max_register = res->end - res->start - 3;
> > +	syscon_regmap_config.name = dev_get_platdata(&pdev->dev);
> 
> Is dev_name(&pdev->dev) can be used for such purpose?

Yes of course.

Either use the automatically generated name or over-ride with
dev->init_name prior to registration or call dev_set_name()
manually. Then retrieve with Alexander's suggestion.

Is there any technical reason why this is not possible with your
implementation?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
