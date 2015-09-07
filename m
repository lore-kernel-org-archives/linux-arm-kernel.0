From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 7 Sep 2015 18:49:02 +0800
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable ACT8865 PMIC driver
In-Reply-To: <3043964.0UPNRg7XJB@diego>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441570566-14001-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <3043964.0UPNRg7XJB@diego>
Message-ID: <55ED6B9E.1030705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMIC RK808 used on many rk3288 boards ,such as Popmetal.
It is a MFD with function regulator and RTC. So if you plan to enable
RK808, please also enable CONFIG_RTC_DRV_RK808.

thanks.

On 2015?09?07? 17:33, Heiko St?bner wrote:
> Hi,
>
> I guess one could rename that to something like
> "ARM: multi_v7_defconfig: Enable regulators used on most rockchip boards"
>
> and as well add
>
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_MFD_RK808=y
> CONFIG_REGULATOR_RK808=y
>
> fan5355 is the driver providing support for the syr82x used on all rk3288
> boards with an act8846.
>
>
>
> Am Sonntag, 6. September 2015, 22:16:04 schrieb Sjoerd Simons:
>> Active Semi act8846 is used as the PMIC on various Rockchip boards,
>> enable the ACT8865 driver to support this.
>>
>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>
>> ---
>>
>>   arch/arm/configs/multi_v7_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig
>> b/arch/arm/configs/multi_v7_defconfig index 25a1d574..7058fef 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -401,6 +401,7 @@ CONFIG_MFD_TPS65090=y
>>   CONFIG_MFD_TPS6586X=y
>>   CONFIG_MFD_TPS65910=y
>>   CONFIG_REGULATOR_AB8500=y
>> +CONFIG_REGULATOR_ACT8865=y
>>   CONFIG_REGULATOR_AS3711=y
>>   CONFIG_REGULATOR_AS3722=y
>>   CONFIG_REGULATOR_AXP20X=y
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
