From: pullip.cho@samsung.com (KyongHo Cho)
Date: Wed, 7 Mar 2012 09:10:42 +0900
Subject: [PATCH v10 2/3] ARM: EXYNOS: Change System MMU platform device
 definitions
In-Reply-To: <CAH9JG2Uvc27UMcsy_Apqo+Td_td_18C6i3vvC8aroBse2=+53w@mail.gmail.com>
References: <002101ccfb73$8684c240$938e46c0$%cho@samsung.com>
 <CAH9JG2Uvc27UMcsy_Apqo+Td_td_18C6i3vvC8aroBse2=+53w@mail.gmail.com>
Message-ID: <CAHQjnOP_mEck35PwhDd7v=MKc+ONFRFxa7i=ro0iMxWy-fuFNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 7:03 PM, Kyungmin Park <kyungmin.park@samsung.com> wrote:
>>
>> -#define S5P_SYSMMU_TOTAL_IPNUM ? ? ? ? ? ? ? EXYNOS4_SYSMMU_TOTAL_IPNUM
>> +#define SYSMMU_DEVNAME_BASE "exynos-sysmmu"
>> +
>> +#define SYSMMU_CLOCK_NAME "sysmmu"
>> +#define SYSMMU_CLOCK_NAME2 "sysmmu_mc"
> What's the meaning of "mc"?
It stands for multi clock gating source.
ISP block has a lot of System MMUs and I merged them in a single
platform device to control them easier. However it is required to access
2 control registers to gating  their clocks. "sysmmu_mc" is prepared for the
case that requires 2 clock descriptors for clock gating.

>> +
>> +#ifdef CONFIG_EXYNOS_DEV_SYSMMU
>> +#include <linux/device.h>
>> +struct platform_device;
>> +
>> +#define SYSMMU_PLATDEV(ipname) exynos_device_sysmmu_##ipname
>> +
>> +extern struct platform_device SYSMMU_PLATDEV(mfc_l);
>> +extern struct platform_device SYSMMU_PLATDEV(mfc_r);
>> +extern struct platform_device SYSMMU_PLATDEV(tv);
>> +extern struct platform_device SYSMMU_PLATDEV(jpeg);
>> +extern struct platform_device SYSMMU_PLATDEV(rot);
> Where's the fimc platform_device?
>
> I think you only tested it with exynos5.

True. I am sorry that I have missed to define it externally.
Thank you.

Cho KyongHo.
