From: ykk@rock-chips.com (Yakir Yang)
Date: Sun, 06 Sep 2015 12:07:22 +0800
Subject: [PATCH v4 11/16] drm: bridge: analogix/dp: add platform device
 type support
In-Reply-To: <55E8E77C.4020305@samsung.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441087620-25586-1-git-send-email-ykk@rock-chips.com>
 <55E8E77C.4020305@samsung.com>
Message-ID: <55EBBBFA.3020801@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

? 09/04/2015 08:36 AM, Krzysztof Kozlowski ??:
> On 01.09.2015 15:07, Yakir Yang wrote:
>
> Empty commit message. Please explain here why you want to add platform
> device type support.
>
> Actually the title is confusing. You are not adding support for platform
> device types but rather adding a field containing type of device.
>
>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2:
>> - Add GNU license v2 declared and samsung copyright
>>
>>   drivers/gpu/drm/exynos/exynos_dp.c              |  1 +
>>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  1 +
>>   include/drm/bridge/analogix_dp.h                | 16 ++++++++++++++++
>>   3 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
>> index 6060d2c..40ef727 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp.c
>> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
>> @@ -224,6 +224,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>>   	dp->dev = dev;
>>   	dp->drm_dev = drm_dev;
>>   
>> +	dp->plat_data.dev_type = EXYNOS_DP;
>>   	dp->plat_data.power_on = exynos_dp_poweron;
>>   	dp->plat_data.power_off = exynos_dp_poweroff;
>>   	dp->plat_data.get_modes = exynos_dp_get_modes;
>> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> index efea045..4934271 100644
>> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
>> @@ -293,6 +293,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
>>   		return ret;
>>   	}
>>   
>> +	dp->plat_data.dev_type = RK3288_DP;
>>   	dp->plat_data.attach = NULL;
>>   	dp->plat_data.get_modes = NULL;
>>   	dp->plat_data.power_on = rockchip_dp_poweron;
>> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
>> index 8b4ffad..7209a64 100644
>> --- a/include/drm/bridge/analogix_dp.h
>> +++ b/include/drm/bridge/analogix_dp.h
>> @@ -1,9 +1,25 @@
>> +/*
>> + * Analogix Core DP (Display Port) interface driver.
>> + *
>> + * Copyright (C) 2012 Samsung Electronics Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; either version 2 of the License, or (at your
>> + * option) any later version.
>> + */
> Two questions:
> 1. Why this change is here? I would rather expect it at patch 3/16 when
> you created this file... That is the usual time for adding copyrights.

Yep, I should move this to 03/16.

> 2. Does this file contains previous Samsung work?

Hmm... I think this haven't contains the previous Samsung works,
but I have the cover the head message from analogix_dp_core driver
(include the copyright, but without ant author).

Thanks
- Yakir

> Best regards,
> Krzysztof
>
>>   #ifndef _ANALOGIX_DP_H_
>>   #define _ANALOGIX_DP_H_
>>   
>>   #include <drm/drm_crtc.h>
>>   
>> +enum analogix_dp_devtype {
>> +	EXYNOS_DP,
>> +	RK3288_DP,
>> +};
>> +
>>   struct analogix_dp_plat_data {
>> +	enum analogix_dp_devtype dev_type;
>>   	struct drm_panel *panel;
>>   
>>   	int (*power_on)(struct analogix_dp_plat_data *);
>>
>
>
>
