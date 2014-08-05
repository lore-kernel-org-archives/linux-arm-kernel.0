From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 05 Aug 2014 16:26:23 +0200
Subject: [PATCH v5 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
In-Reply-To: <53E0E420.8060207@linaro.org>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com>
 <53E0E420.8060207@linaro.org>
Message-ID: <53E0E98F.5020706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2014 16:03, Daniel Lezcano wrote:
> On 08/05/2014 03:34 PM, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> This patch series adds support for AFTR idle mode on boards with
>> secure firmware enabled and allows EXYNOS cpuidle driver usage on
>> Exynos4x12 SoCs.
>>
>> It has been tested on Trats2 board (using Exynos4412 SoC with secure
>> firmware enabled) on which AFTR mode reduces power consumption by ~12%
>> when EXYNOS cpuidle driver is enabled (in both cases the default
>> exynos_defconfig config is used and CPU1-3 are offlined).
>
> As a sidenote:
>
> On my odroid-U2:
>   * 4 cpus online -> 130 mA
>   * 3 cpus online -> 164 mA
>   * 2 cpus online -> 160 mA
>   * 1 cpu online  -> 157 mA
>
> So were are consuming more when there are unplugged cpu ... any ideas ?

On which tree are you testing? Current next has ARMCLK down feature 
enabled. ARMCLK down may stop working after hotunplugging CPU:
http://www.spinics.net/lists/arm-kernel/msg352890.html

That was observed especially on Exynos4212 where ARMCLK down stops 
working permanently. On Trats2 (Exynos4412) the clock down stopped only 
a for short period after disabling CPU.

Best regards,
Krzysztof
