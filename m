From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 28 Jul 2015 11:43:42 +0200
Subject: linux-next: build failure after merge of the tip tree
In-Reply-To: <55B74042.6070600@arm.com>
References: <20150728124324.40f44f01@canb.auug.org.au>
 <55B74042.6070600@arm.com>
Message-ID: <55B74ECE.5060409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep, Stephen,

On 28/07/2015 10:41, Sudeep Holla wrote:
> Hi Stephen,
> 
> On 28/07/15 03:43, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the tip tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> arch/arm/mach-mvebu/board-v7.c: In function 'mvebu_init_irq':
>> arch/arm/mach-mvebu/board-v7.c:138:3: error: implicit declaration of function 'gic_set_irqchip_flags' [-Werror=implicit-function-declaration]
>>     gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
>>     ^
>>
>> Caused by commit
>>
>>    e6f134f8e30e ("ARM: mvebu: Allow using the GIC for wakeup in standby mode")
>>
>> from the mvebu tree interacting with commit
>>
>>    0d3f2c92e004 ("irqchip/gic: Remove redundant gic_set_irqchip_flags")
>>
>> from the tip tree.
>>
>> I have applied the following merge fix patch for today:
>>
> 
> Thanks for the fix, I was aware of this and asked Thomas Petazzoni
> and Gregory CLEMENT to revert the commit e6f134f8e30e if possible
> yesterday [1]
> 

I've just remove the commit from my branches, it should be OK now.


Thanks,

Gregory


> Regards,
> Sudeep
> 
> [1] 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359585.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
