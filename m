From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 26 Aug 2015 17:27:59 +0800
Subject: [RESEND PATCH v16 3/4] soc: rockchip: power-domain: Add power
 domain driver
In-Reply-To: <7hwpwjaxxv.fsf@deeprootsystems.com>
References: <1440487486-6154-1-git-send-email-wxt@rock-chips.com>
 <1440487486-6154-4-git-send-email-wxt@rock-chips.com>
 <7hwpwjaxxv.fsf@deeprootsystems.com>
Message-ID: <55DD869F.9010309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?08?26? 04:57, Kevin Hilman ??:
> Caesar Wang <wxt@rock-chips.com> writes:
>
>> This driver is found on RK3288 SoCs.
>>
>> In order to meet high performance and low power requirements, a power
>> management unit is designed or saving power when RK3288 in low power
>> mode.
>> The RK3288 PMU is dedicated for managing the power of the whole chip.
>>
>> PMU can work in the Low Power Mode by setting bit[0] of PMU_PWRMODE_CON
>> register. After setting the register, PMU would enter the Low Power mode.
>> In the low power mode, pmu will auto power on/off the specified power
>> domain, send idle req to specified power domain, shut down/up pll and
>> so on. All of above are configurable by setting corresponding registers.
>>
>> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> [...]
>
>> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
>> new file mode 100644
>> index 0000000..87a09c3
>> --- /dev/null
>> +++ b/drivers/soc/rockchip/Kconfig
>> @@ -0,0 +1,13 @@
>> +#
>> +# Rockchip Soc drivers
>> +#
>> +config PM_GENERIC_DOMAINS
> Why are you (re)defining this config option?  This name is already used in kernel/pm/Kconfig.

Fixed.

----
Thanks,
Caesar

> Kevin
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
