From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 4 Dec 2009 22:20:51 +0800
Subject: [PATCH 4/4]ARM: NUC900: enable uart support for nuc932
In-Reply-To: <20091203194132.GA27666@n2100.arm.linux.org.uk>
References: <4B167281.1090708@gmail.com>
	<20091203194132.GA27666@n2100.arm.linux.org.uk>
Message-ID: <e68bb3470912040620v7d6d9c67s176f6e8aef8a3638@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/4 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Dec 02, 2009 at 09:58:25PM +0800, Wan ZongShun wrote:
>> diff --git a/arch/arm/mach-w90x900/clock.h b/arch/arm/mach-w90x900/clock.h
>> index b9ea2e6..2a2a54a 100644
>> --- a/arch/arm/mach-w90x900/clock.h
>> +++ b/arch/arm/mach-w90x900/clock.h
>> @@ -14,8 +14,10 @@
>>
>> ?#ifndef CONFIG_CPU_NUC932
>> ?#define EXTCLK ? ? ? 15000000
>> +#define UARTCLK ? ? ?11313600
>> ?#else
>> ?#define EXTCLK ? ? ? 27000000
>> +#define UARTCLK ? ? ?57139200
>> ?#endif
>
> As far as I can see, these are the only thing which prevent a single
> kernel being built to cover both NUC900 and NUC932.
>
> Can we make their selection something which is done at runtime instead
> of compile time? ?This comments goes for patch 5837/1 in the patch
> system as well.
>
Do you mean that I should use following form instead?

"if (machine_is_nuc932evb())"
         code....


-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
