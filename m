From: r.sricharan@ti.com (R, Sricharan)
Date: Mon, 7 May 2012 09:05:50 +0530
Subject: [PATCH 12/13] ARM: OMAP5: Add the build support
In-Reply-To: <20120504225857.GB5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
 <20120504225857.GB5613@atomide.com>
Message-ID: <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

>> - ? ? select NEON if ARCH_OMAP3 || ARCH_OMAP4
>> + ? ? select NEON if ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
>> ? ? ? select SERIAL_OMAP
>> ? ? ? select SERIAL_OMAP_CONSOLE
>> ? ? ? select I2C
>
> If we add CONFIG_SOC_OMAP3PLUS and CONFIG_SOC_OMAP4PLUS, then
> this becomes more future proof with select NEON if SOC_OMAP3PLUS.
>
 ok. will change this.

>> +config ARCH_OMAP5
>> + ? ? bool "TI OMAP5"
>> + ? ? depends on ARCH_OMAP2PLUS
>> + ? ? select CPU_V7
>> + ? ? select ARM_GIC
>> + ? ? select HAVE_SMP
>
> No need to have depends on ARCH_OMAP2PLUS, it's all inside
> if ARCH_OMAP2PLUS anyways. I removed those already once, but that
> had to be reverted because the patch was doing other things too
> that did not work out too well..
>ll
 ok, will remove this then.

>> +config MACH_OMAP5_SEVM
>> + ? ? bool "OMAP5 sevm Board"
>> + ? ? depends on ARCH_OMAP5
>> +
>> ?config OMAP3_EMU
>> ? ? ? bool "OMAP3 debugging peripherals"
>> ? ? ? depends on ARCH_OMAP3
>
> No need for it here either. Actually, I think this whole chunk
> can be now left out since it's DT based?
>he
 ok, but the concern here was that without this macro
 the print from compress and subsequently early
prints appear broken.

machine_is_omap5_sevm becomes zero without this config and
machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
uncompress.h.

Thanks,
 Sricharan
