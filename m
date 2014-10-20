From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 20 Oct 2014 15:59:45 -0700
Subject: [PATCH v5 1/6] ARM: cygnus: Initial support for Broadcom Cygnus
 SoC
In-Reply-To: <4779079.vI0gT0iWvg@wuerfel>
References: <1413341936-17606-2-git-send-email-sbranden@broadcom.com>
 <4779079.vI0gT0iWvg@wuerfel>
Message-ID: <544593E1.90608@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-10-20 12:55 PM, Arnd Bergmann wrote:
> On Tuesday 14 October 2014 19:58:51 Scott Branden wrote:
>>   if ARCH_BCM
>>
>> +menu "iProc SoC based Machine types"
>> +       config ARCH_BCM_IPROC
>> +               bool
>> +               select ARM_GIC
>> +               select CACHE_L2X0
>> +               select HAVE_ARM_SCU if SMP
>> +               select HAVE_ARM_TWD if SMP
>> +               select ARM_GLOBAL_TIMER
>> +
>> +               select CLKSRC_MMIO
>> +               select ARCH_REQUIRE_GPIOLIB
>> +               select ARM_AMBA
>> +               select PINCTRL
>> +               help
>> +                 This enables support for systems based on Broadcom IPROC architected SoCs.
>> +                 The IPROC complex contains one or more ARM CPUs along with common
>> +                 core periperals. Application specific SoCs are created by adding a
>> +                 uArchitecture containing peripherals outside of the IPROC complex.
>> +                 Currently supported SoCs are Cygnus.
>> +
>> +       config ARCH_BCM_CYGNUS
>> +               bool "Broadcom Cygnus Support" if ARCH_MULTI_V7
>
> You still have a three-level menu structure. Please fix.

Hi Arnd, we have ARCH_BCM->ARCH_BCM_CYGNUS.

ARCH_BCM_IPROC is silent and selected by ARCH_BCM_CYGNUS.  This was the 
change made between v3 and v5.

Is there something else to be done here?
>
>> +static const char const *bcm_cygnus_dt_compat[] = {
>> +       "brcm,cygnus",
>> +       NULL,
>> +};
>> +
>> +DT_MACHINE_START(BCM_CYGNUS_DT, "Broadcom Cygnus SoC")
>> +       .l2c_aux_val    = 0,
>> +       .l2c_aux_mask   = ~0,
>> +       .dt_compat = bcm_cygnus_dt_compat,
>> +MACHINE_END
>>
> This looks good.
>
> 	Arnd
>
