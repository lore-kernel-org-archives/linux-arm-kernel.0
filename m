From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 13 Nov 2009 20:50:51 -0800
Subject: [PATCH 06/10] mfd add subdevs in 88pm860x
In-Reply-To: <771cded00911130100u2a97c6f4v968e40b912650482@mail.gmail.com>
References: <771cded00911130100u2a97c6f4v968e40b912650482@mail.gmail.com>
Message-ID: <20091114045051.GA4463@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 04:00:44AM -0500, Haojian Zhuang wrote:
> 
> -		count = ARRAY_SIZE(pm8607_devs);
> -		for (i = 0; i < count; i++) {
> -			ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
> -					      1, NULL, 0);
> -			if (ret != 0) {
> -				dev_err(chip->dev, "Failed to add subdevs\n");
> -				goto out;
> -			}
> +		mfd_add_devices(chip->dev, 0, &regulator_devs[0],
> +				      ARRAY_SIZE(regulator_devs),
> +				      &regulator_resources[0], 0);
> +
> +		if (pdata && pdata->touch) {
> +			mfd_add_devices(chip->dev, 0, &touch_devs[0],
> +					ARRAY_SIZE(touch_devs),
> +					&touch_resources[0], 0);

Where did error handling go?

-- 
Dmitry
