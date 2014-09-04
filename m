From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 4 Sep 2014 10:06:00 -0700
Subject: [PATCH v4 1/4] thermal: rockchip: add driver for thermal
In-Reply-To: <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <20140904170559.GB10224@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

On Wed, Sep 03, 2014 at 10:10:36AM +0800, Caesar Wang wrote:
> +static int rockchip_thermal_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_thermal_data *data = platform_get_drvdata(pdev);
> +
> +	rockchip_thermal_control(data, false);
> +
> +	thermal_zone_device_unregister(data->tz);
> +	cpufreq_cooling_unregister(data->cdev);
> +	cpufreq_cooling_unregister(data->cdev);

It looks like we are unregistering the same cooling device one too many times.

Thanks.

-- 
Dmitry
