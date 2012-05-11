From: r.sricharan@ti.com (R, Sricharan)
Date: Fri, 11 May 2012 11:46:32 +0530
Subject: [PATCH 1/4] ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-2-git-send-email-r.sricharan@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA217D2@DBDE01.ent.ti.com>
Message-ID: <CAJ7qFSf9=h-hjSwrcd+n=zK4HyB+=DXGrqsgsMvaL_f1xyQQog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav,
[snip]
>> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
>> index d0ef57c..095bee8 100644
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -156,7 +156,7 @@ struct dpll_data {
>> ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?min_divider;
>> ? ? ? u16 ? ? ? ? ? ? ? ? ? ? max_divider;
>> ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?modes;
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#ifdef CONFIG_SOC_HAS_OMAP_DPLL
>> ? ? ? void __iomem ? ? ? ? ? ?*autoidle_reg;
>> ? ? ? void __iomem ? ? ? ? ? ?*idlest_reg;
>> ? ? ? u32 ? ? ? ? ? ? ? ? ? ? autoidle_mask;
>> @@ -167,7 +167,7 @@ struct dpll_data {
>> ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?auto_recal_bit;
>> ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?recal_en_bit;
>> ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?recal_st_bit;
>> -# ?endif
>> +#endif
>
> I had submitted similar patch recently, and Kevin had suggested that
> Instead of adding config option, we shoule simply get rid of this ifdef
> completely.
>
> Refer to
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg68293.html
>
>
> Waiting for Paul to conform here.
>
 Thanks for pointing that out. Will check on this and Paul's PRCM series
 cleanup series then.

Thanks,
 Sricharan
