From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Apr 2014 16:33:58 +0100
Subject: [PATCH 10/10] hwmon: vexpress: Use devm helper for hwmon device
 registration
In-Reply-To: <20140430152754.GA30924@roeck-us.net>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-11-git-send-email-pawel.moll@arm.com>
 <535EDD49.8050107@roeck-us.net> <1398870979.24255.37.camel@hornet>
 <20140430152754.GA30924@roeck-us.net>
Message-ID: <1398872038.24255.41.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-30 at 16:27 +0100, Guenter Roeck wrote:
> > I'm not sure I understand the question. The other patch from the series
> 
> The code above seems to change from
> 
>    	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
> 	if (!data->reg)
> 		return -ENODEV;
> 
> to
> 
>    	data->reg = devm_regmap_init_vexpress_config(&pdev->dev);
> 	if (IS_ERR(data->reg))
> 		return PTR_ERR(data->reg);
> 
> as part of this patch. This suggests that the return value from
> devm_regmap_init_vexpress_config may have changed from NULL to 
> ERR_PTR. Is my understanding wrong ?

No, you've got it right, but it's me making a mistake in patch splitting
- it is supposed to be a part of the first patch. Thanks for spotting
this!

Pawel
