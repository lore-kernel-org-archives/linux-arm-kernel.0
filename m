From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 6 Aug 2015 22:57:34 +0800
Subject: [RFC PATCH 3/8] drm: bridge: analogix_dp: split exynos dp driver
 to bridge dir
In-Reply-To: <000101d0d054$f34e9c70$d9ebd550$@com>
References: <1438868947-22132-1-git-send-email-ykk@rock-chips.com>
 <1438870763-23796-1-git-send-email-ykk@rock-chips.com>
 <000101d0d054$f34e9c70$d9ebd550$@com>
Message-ID: <55C375DE.5070001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo,

? 2015/8/6 22:33, Jingoo Han ??:
> On Thursday, August 06, 2015 11:19 PM, Yakir Yang wrote:
>> Split the dp core driver from exynos directory to bridge
>> directory, and rename the core driver to analogix_dp_*,
>> leave the platform code to analogix_dp-exynos.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>>   drivers/gpu/drm/bridge/Kconfig                     |    5 +
>>   drivers/gpu/drm/bridge/Makefile                    |    1 +
>>   .../exynos_dp_core.c => bridge/analogix_dp_core.c} |  751 +++++-------
>>   drivers/gpu/drm/bridge/analogix_dp_core.h          |  286 +++++
>>   drivers/gpu/drm/bridge/analogix_dp_reg.c           | 1266 ++++++++++++++++++++
>>   .../exynos_dp_reg.h => bridge/analogix_dp_reg.h}   |  260 ++--
>>   drivers/gpu/drm/exynos/Kconfig                     |    5 +-
>>   drivers/gpu/drm/exynos/Makefile                    |    2 +-
>>   drivers/gpu/drm/exynos/analogix_dp-exynos.c        |  240 ++++
>>   drivers/gpu/drm/exynos/exynos_dp_core.h            |  283 -----
>>   include/drm/bridge/analogix_dp.h                   |   22 +
>>   11 files changed, 2287 insertions(+), 834 deletions(-)
>>   rename drivers/gpu/drm/{exynos/exynos_dp_core.c => bridge/analogix_dp_core.c} (54%)
>>   create mode 100644 drivers/gpu/drm/bridge/analogix_dp_core.h
>>   create mode 100644 drivers/gpu/drm/bridge/analogix_dp_reg.c
>>   rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix_dp_reg.h} (63%)
>>   create mode 100644 drivers/gpu/drm/exynos/analogix_dp-exynos.c
>>   delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
>>   create mode 100644 include/drm/bridge/analogix_dp.h
>>
>> [...]
>> rename from drivers/gpu/drm/exynos/exynos_dp_core.c
>> rename to drivers/gpu/drm/bridge/analogix_dp_core.c
>> index aa99e23..28724d4 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix_dp_core.c
>> @@ -1,7 +1,8 @@
>>   /*
>> - * Samsung SoC DP (Display Port) interface driver.
>> + * Analogix Core DP (Display Port) interface driver.
>>    *
>>    * Copyright (C) 2012 Samsung Electronics Co., Ltd.
>> + * Copyright (C) FuZhou Rockchip Electronics Co., Ltd.
> What is the reason to add this copyright?
> You just replace 'exynos' prefix with 'analogix' prefix.
> I cannot find the reason to add the copyright.
>

Oh! Thanks for your point out, sorry for this one

- Yakir
>>    *
>> --
>> 2.1.2
>
>
>
>
