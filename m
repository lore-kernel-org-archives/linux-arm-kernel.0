From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Fri, 05 Sep 2014 08:33:23 +0800
Subject: [PATCH v4 1/4] thermal: rockchip: add driver for thermal
In-Reply-To: <20140904170559.GB10224@core.coreip.homeip.net>
References: <1409710239-19941-1-git-send-email-caesar.wang@rock-chips.com>
 <1409710239-19941-2-git-send-email-caesar.wang@rock-chips.com>
 <20140904170559.GB10224@core.coreip.homeip.net>
Message-ID: <540904D3.1070004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014?09?05? 01:06, Dmitry Torokhov ??:
> Hi Caesar,
>
> On Wed, Sep 03, 2014 at 10:10:36AM +0800, Caesar Wang wrote:
>> +static int rockchip_thermal_remove(struct platform_device *pdev)
>> +{
>> +	struct rockchip_thermal_data *data = platform_get_drvdata(pdev);
>> +
>> +	rockchip_thermal_control(data, false);
>> +
>> +	thermal_zone_device_unregister(data->tz);
>> +	cpufreq_cooling_unregister(data->cdev);
>> +	cpufreq_cooling_unregister(data->cdev);
> It looks like we are unregistering the same cooling device one too many times.
>
> Thanks.
>
yes,I made a stupid mistake.  Thanks~

-- 
Best regards,
Caesar
