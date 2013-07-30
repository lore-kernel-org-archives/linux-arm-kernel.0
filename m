From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 30 Jul 2013 18:08:56 +0530
Subject: [PATCH v2 3/8] ARM: DRA7: Reuse all of PRCM and MPUSS SMP infra
In-Reply-To: <51F7B100.2020600@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-4-git-send-email-rnayak@ti.com> <51F7B100.2020600@ti.com>
Message-ID: <51F7B3E0.9020005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 July 2013 05:56 PM, Nishanth Menon wrote:
> On 07/30/2013 06:25 AM, Rajendra Nayak wrote:
>> From: R Sricharan <r.sricharan@ti.com>
> [...]
>>   # Clock framework
>>   obj-$(CONFIG_ARCH_OMAP2)        += $(clock-common) clock2xxx.o
>> @@ -181,6 +187,8 @@ obj-$(CONFIG_SOC_AM33XX)        += $(clock-common) dpll3xxx.o
>>   obj-$(CONFIG_SOC_AM33XX)        += cclock33xx_data.o
>>   obj-$(CONFIG_SOC_OMAP5)            += $(clock-common)
>>   obj-$(CONFIG_SOC_OMAP5)            += dpll3xxx.o dpll44xx.o
>> +obj-$(CONFIG_SOC_DRA7XX)        += $(clock-common)
>> +obj-$(CONFIG_SOC_DRA7XX)        += dpll3xxx.o dpll44xx.o
>>
> 
> are these in sync with DRA7 support being introduced for clock data in [1]?

I don't want to have a dependency on those patches since I am not sure of them
making it into 3.12.

> 
> 
> [1] http://marc.info/?l=linux-omap&m=137456411706971&w=2
> 
