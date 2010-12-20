From: nm@ti.com (Nishanth Menon)
Date: Mon, 20 Dec 2010 08:16:55 -0600
Subject: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
In-Reply-To: <ff992259ca9324925ce680a11cae0245@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-3-git-send-email-nm@ti.com>
	<ff992259ca9324925ce680a11cae0245@mail.gmail.com>
Message-ID: <4D0F6557.2090101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar had written, on 12/20/2010 12:47 AM, the following:
[..]
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> index 2c20fcf..3fbd1e5 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -42,6 +42,7 @@
>>  				OMAP3430_PM_PREPWSTST)
>>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD +
>> OMAP2_PM_PWSTCTRL
>>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>> +#define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
> We need to avoid these macro's calculating VA directly. But I guess
> it needs to be done more than just this line and hence can be done
> in a separate patch.
yes - with the cleanups planned for this file, we could probably add it 
to that set I guess.

-- 
Regards,
Nishanth Menon
