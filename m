From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Mon, 27 Nov 2017 01:26:32 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDAxLzExXSBJbml0aWFsaXplIHRoZSBtYXBwaW5nIG9m?=
 =?gb2312?Q?_KASan_shadow_memory?=
In-Reply-To: <20171123153133.mwyuxthy2ysktx7c@lakrids.cambridge.arm.com>
References: <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
 <20171121122938.sydii3i36jbzi7x4@lakrids.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0069032@dggemm510-mbx.china.huawei.com>
 <20171123153133.mwyuxthy2ysktx7c@lakrids.cambridge.arm.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C006C4ED@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 23, 2017  23:32  Mark Rutland [mailto:mark.rutland at arm.com] wrote:
>On Wed, Nov 22, 2017 at 12:56:44PM +0000, Liuwenliang (Abbott Liu) wrote:
>> +static inline u64 get_ttbr0(void)
>> +{
>> + if (IS_ENABLED(CONFIG_ARM_LPAE))
>> +         return read_sysreg(TTBR0_64);
>> + else
>> +         return (u64)read_sysreg(TTBR0_32);
>> +}
>
>> +static inline u64 get_ttbr1(void)
>> +{
>> + if (IS_ENABLED(CONFIG_ARM_LPAE))
>> +         return read_sysreg(TTBR1_64);
>> + else
>> +         return (u64)read_sysreg(TTBR1_32);
>> +}
>
>In addition to the whitespace damage that need to be fixed, there's no
>need for the u64 casts here. The compiler will implicitly cast to the
>return type, and as u32 and u64 are both arithmetic types, we don't need
>an explicit cast here.

Thanks for your review.
I'm going to change it in the new version.  


-----????-----
???: Mark Rutland [mailto:mark.rutland at arm.com] 
????: 2017?11?23? 23:32
???: Liuwenliang (Abbott Liu)
??: Marc Zyngier; tixy at linaro.org; mhocko at suse.com; grygorii.strashko at linaro.org; catalin.marinas at arm.com; linux-mm at kvack.org; glider at google.com; afzal.mohd.ma at gmail.com; mingo at kernel.org; Christoffer Dall; f.fainelli at gmail.com; mawilcox at microsoft.com; linux at armlinux.org.uk; kasan-dev at googlegroups.com; Dailei; linux-arm-kernel at lists.infradead.org; aryabinin at virtuozzo.com; labbott at redhat.com; vladimir.murzin at arm.com; keescook at chromium.org; arnd at arndb.de; Zengweilin; opendmb at gmail.com; Heshaoliang; tglx at linutronix.de; dvyukov at google.com; ard.biesheuvel at linaro.org; linux-kernel at vger.kernel.org; Jiazhenghua; akpm at linux-foundation.org; robin.murphy at arm.com; thgarnie at google.com; kirill.shutemov at linux.intel.com
??: Re: [PATCH 01/11] Initialize the mapping of KASan shadow memory

On Wed, Nov 22, 2017 at 12:56:44PM +0000, Liuwenliang (Abbott Liu) wrote:
> +static inline u64 get_ttbr0(void)
> +{
> + if (IS_ENABLED(CONFIG_ARM_LPAE))
> +         return read_sysreg(TTBR0_64);
> + else
> +         return (u64)read_sysreg(TTBR0_32);
> +}

> +static inline u64 get_ttbr1(void)
> +{
> + if (IS_ENABLED(CONFIG_ARM_LPAE))
> +         return read_sysreg(TTBR1_64);
> + else
> +         return (u64)read_sysreg(TTBR1_32);
> +}

In addition to the whitespace damage that need to be fixed, there's no
need for the u64 casts here. The compiler will implicitly cast to the
return type, and as u32 and u64 are both arithmetic types, we don't need
an explicit cast here.

Thanks,
Mark.
