From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 18 Oct 2017 10:16:08 +0530
Subject: [RFC PATCH v4 6/8] drm/bridge/analogix: Do not use device's
 drvdata
In-Reply-To: <000101d347a1$cd216160$67642420$@gmail.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-7-jeffy.chen@rock-chips.com>
 <000101d347a1$cd216160$67642420$@gmail.com>
Message-ID: <c11c1115-58fb-f6d4-56f8-05277a9ccea9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/18/2017 05:13 AM, Jingoo Han wrote:
> On Tuesday, October 17, 2017 6:16 AM, Jeffy Chen wrote:
>>
>> From: Tomasz Figa <tfiga@chromium.org>
>>
>> The driver that instantiates the bridge should own the drvdata, as all
>> driver model callbacks (probe, remove, shutdown, PM ops, etc.) are also
>> owned by its driver struct. Moreover, storing two different pointer
>> types in driver data depending on driver initialization status is barely
>> a good practice and in fact has led to many bugs in this driver.
>>
>> Let's clean up this mess and change Analogix entry points to simply
>> accept some opaque struct pointer, adjusting their users at the same
>> time to avoid breaking the compilation.
>>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 

This depends on previous patches of the series. I guess it would be easier
to queue this to drm-misc as a part of the eDP support series. For that:

Acked-by: Archit Taneja <architt@codeaurora.org>

> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> 
> Best regards,
> Jingoo Han
> 
>> ---
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 50 +++++++++--------
>> -----
>>   drivers/gpu/drm/exynos/exynos_dp.c                 | 26 ++++++-----
>>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 47
> +++++++++++-------
>> --
>>   include/drm/bridge/analogix_dp.h                   | 19 ++++----
>>   4 files changed, 73 insertions(+), 69 deletions(-)
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
