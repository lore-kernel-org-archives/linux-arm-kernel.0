From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Thu, 14 Jun 2012 13:48:48 +0200
Subject: [PATCH 2/5] ARM: at91: Implementation of PMC clks using the common
 clk framework.
In-Reply-To: <20120612170306.GD19410@gmail.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
 <1336812838-3649-3-git-send-email-linux-arm@overkiz.com>
 <20120612170306.GD19410@gmail.com>
Message-ID: <4FD9CFA0.30800@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2012 19:03, Mike Turquette wrote:
> On 20120512-10:53, Boris BREZILLON wrote:
>> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
>> index 79d0f60..29f8812 100644
>> --- a/arch/arm/mach-at91/Makefile
>> +++ b/arch/arm/mach-at91/Makefile
>> @@ -6,8 +6,11 @@ obj-y		:= irq.o gpio.o setup.o
>>  obj-m		:=
>>  obj-n		:=
>>  obj-		:=
>> -
>> +ifeq ($(CONFIG_COMMON_CLK),y)
>> +obj-$(CONFIG_AT91_PMC_UNIT)	+= pmc-osc.o pmc-pll.o pmc-master.o pmc-sys.o pmc-periph.o pmc-prog.o pmc.o
>> +else
>>  obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
>> +endif
> 
> Hi Boris,
> 
> Looks like the old platform clock code is not removed in this series.
> Is this just a work in progress or do you want to merge in AT91 support
> for common clk while leaving the old clock code merged in?
> 
This is a work in progress.
I'd like to have more reviews from at91 maitainers before removing the old at91 clock implementation.

Do you have some comments on other parts of this patch serie (it's been a month and nobody reviewed it yet)?

> Regards,
> Mike
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
