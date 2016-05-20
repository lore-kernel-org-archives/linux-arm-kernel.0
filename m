From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 May 2016 11:13:41 -0400
Subject: [PATCH] ARM: dts: exynos: Remove unneded always-on for regulators
 on Peach boards
In-Reply-To: <573EDEF2.8020903@samsung.com>
References: <1463694753-7259-1-git-send-email-javier@osg.samsung.com>
 <573EDEF2.8020903@samsung.com>
Message-ID: <66cd7fed-c281-0645-0a60-5e1300419642@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

Thanks a lot for the feedback.

On 05/20/2016 05:54 AM, Krzysztof Kozlowski wrote:
> On 05/19/2016 11:52 PM, Javier Martinez Canillas wrote:
>> The regulator always-on property should only be used for regulators
>> that either can't be disabled or the drivers for the client devices
>> are not enabling the regulator and so being disabled due to unused.
>>
>> There are some max77802 regulators in the Peach Pit and Pi boards
>> that are always-on but shouldn't since they are enabled by drivers:
>>
>> BUCK5 is max77802 inl1 supply
>> BUCK7 is max77802 inl{2,10} supply
>> BUCK9 is max77802 inl{3,4,5,7} supply
>> BUCK10 is mmc1 vqmmc supply
>> LDO9 is adc vdd supply
>>
>> This patch removes the always-on property for these regulators.
>>
>> Some regulators should remain always-on even when they are used as
>> input supplies, because these regulators are also used by other
>> components that are not described in the DT, for example:
>>
>> LDO10 is hdmi vdd_osc supply but it's also used as input supply for
>> the Exynos5420 temperature sensor.
> 
> I don't have the schematics, so just guessing: by temperature sensor do
> you mean the tmu_cpu* node (supplying power to VDD_TS01/23/4)?
>

Yes, I meant that the LDO10 regulator supplies 1v8 to VDD18_TS{01,23,4}.
 
> If yes then you can also change it, like on Odroid XU boards.
>

Indeed, I think that should be a separate patch though. I'll do it
next week since I don't have access to the machine today to test.
 
>>
>> LDO8 is hdmi vdd and vdd_pll supply but it's also used as supply for
>> the Exynos5420 Display port.
>>
>> BUCK2 and BUCK6 are the vdd supplies for the EAGLE and KFC clusters.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 -----
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 -----
>>  2 files changed, 10 deletions(-)
> 
> Anyway,
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>

Thanks!
 
> Best regards,
> Krzysztof
> --

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
