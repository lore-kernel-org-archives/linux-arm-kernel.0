From: r.sricharan@ti.com (R, Sricharan)
Date: Wed, 9 May 2012 14:36:17 +0530
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120507173351.GB5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
 <20120507173351.GB5088@atomide.com>
Message-ID: <CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

[snip]
>> >> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) || ? ?\
>> >> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? defined(CONFIG_ARCH_OMAP3))
>> >> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
>> >> + ? ? ? ? ? ? !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
>> >> +
>> >> ?static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>> >> ?{
>> >> ? ? ? WARN(1, "prm: omap2xxx/omap3xxx specific function and "
>> >
>> > Maybe these functions could be just set up as __weak to avoid the
>> > ifdeffery?
>> >
>> ?sorry to understand,
>> ?you mean make this weak and have a strong override for OMAP2 ?
>
> Yeah that should do the trick, right?
 Ok, There are multiple functions under that #ifdef.
 Also i see that __weak cannot be used for inline functions.
So should those functions should be moved to .c file and qualify them
 __weak. There is already a strong override for OMAP2 and 3 which
should not be a problem.

[OR]

 So after the cleanup patch introducing CONFIG_SOC_OMAP4PLUS
 it can be changed as
 #ifdef (CONFIG_SOC_OMAP4PLUS) && !(defined(CONFIG_ARCH_OMAP2) ||
defined(CONFIG_ARCH_OMAP3))

So this will avoid patching this for the future socs. ?

Thanks,
 Sricharan
