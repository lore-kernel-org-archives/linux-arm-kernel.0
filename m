From: caesar.upstream@gmail.com (Caesar Wang)
Date: Thu, 17 Sep 2015 17:28:10 +0800
Subject: [PATCH 1/3] clocksource: rockchip: Make the driver more
 readability and compatible
In-Reply-To: <55FA83D5.9010504@linaro.org>
References: <1442476272-31723-1-git-send-email-wxt@rock-chips.com>
 <1442476272-31723-2-git-send-email-wxt@rock-chips.com>
 <55FA83D5.9010504@linaro.org>
Message-ID: <55FA87AA.4040807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,


? 2015?09?17? 17:11, Daniel Lezcano ??:
>
> Hi Caesar,
>
>
> On 09/17/2015 09:51 AM, Caesar Wang wrote:
>> Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
>> There are some failure with build up on timer driver for rockchip.
>>
>> logs:
>> ...
>> drivers/clocksource/rockchip_timer.c:156:13: error: 'NO_IRQ' undeclared
>
> I think the NO_IRQ definition is missing for ARM64.

Yep, Maybe better to compatible if we don't use the 'NO_IRQ',

>
>> /tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand 1 --
>> `dsb`
>> ...
>>
>> The problem was different semantics of dsb on btw arm32 and arm64,
>> Here we can convert the dsb with insteading of dsb(sy).
>
> What happens to ARM32 then ?
>

The dsb() is ok for ARM32, the ARM32/64 are OK if we can convert the 
dsb() to dsb(sy).
I believe all drivers with 'dsb()' have same issue on ARM64 platform.

>> Meanwhile, I change a bit to make the code more readability for driver
>> when I check the code style.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
>


-- 
Thanks,
Caesar
