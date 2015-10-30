From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 30 Oct 2015 09:05:39 +0800
Subject: [PATCH v8 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <1972811.93U5ryFMyR@phil>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1972811.93U5ryFMyR@phil>
Message-ID: <5632C263.8050209@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 10/30/2015 01:49 AM, Heiko Stuebner wrote:
> Am Mittwoch, 28. Oktober 2015, 16:15:43 schrieb Yakir Yang:
>> Hi all,
>>
>>     The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
>> share the same IP, so a lot of parts can be re-used. I split the common
>> code into bridge directory, then rk3288 and exynos only need to keep
>> some platform code. Cause I can't find the exact IP name of exynos dp
>> controller, so I decide to name dp core driver with "analogix" which I
>> find in rk3288 eDP TRM
>>
>> But  there are still three light registers setting differents bewteen
>> exynos and rk3288.
>> 1. RK3288 have five special pll resigters which not indicata in exynos
>>     dp controller.
>> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>>     between rk3288 and exynos.
>> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>>     register).
>>
>> This series have been well tested on Rockchip platform with eDP panel on
>> Jerry Chromebook and Display Port Monitor on RK3288 board. Also I have
>> tested on Samsung Snow and Peach Pit Chromebooks, and thanks to Javier at Samsung
>> help to retest the whole series on Samsung Exynos5800 Peach Pi Chromebook,
>> glad to say that things works rightlly.
> Patch 15/17 looks like it didn't make it? I haven't found it in neither my
> inbox nor in the linux-rockchip list archive? So I've used the v7 version
> for my tests.

Oops, thanks for your reminding, I would send it now.

> This series on a rk3288-veyron-pinky and rk3288-veyron-jerry
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>

Thanks,

- Yakir

>
