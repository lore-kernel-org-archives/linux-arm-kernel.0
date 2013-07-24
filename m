From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 24 Jul 2013 11:48:30 +0100
Subject: [PATCH 0/5] ARM: DT: remove redundant DT related code
In-Reply-To: <alpine.LFD.2.03.1307231543480.15022@syhkavp.arg>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <alpine.LFD.2.03.1307231543480.15022@syhkavp.arg>
Message-ID: <51EFB0FE.8080503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 20:45, Nicolas Pitre wrote:
> On Tue, 23 Jul 2013, Sudeep KarkadaNagesha wrote:
> 
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Hi,
>>
>> As part of my changes to remove duplicate code for parsing cpu nodes
>> in the device tree, I found few unnecessary code mostly around smp_init_cpus.
>> Most of the ARM Cortex A9 based platforms use SCU to get the number of cpus
>> while many others depend on the device tree.
>>
>> Even on DT based platforms using SCU, they can be made to depend on DT
>> to cpu count simplifying smp_init_cpus. In fact arm_dt_init_cpu_maps called
>> before smp_init_cpus, already does the device tree parsing, validating
>> nr_cpu_ids and setting the cpu_possible_mask appropriately. 
>>
>> However this series targets only the platforms using DT for cpu count
>> (i.e. not using SCU)
>>
>> Regards,
>> Sudeep
> For the whole series:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
Thanks for the review.

Regards,
Sudeep
