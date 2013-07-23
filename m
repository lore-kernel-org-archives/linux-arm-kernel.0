From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 23 Jul 2013 13:36:32 +0100
Subject: [PATCH 0/5] ARM: DT: remove redundant DT related code
In-Reply-To: <51EE779A.8000205@monstr.eu>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51EE779A.8000205@monstr.eu>
Message-ID: <51EE78D0.50803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/13 13:31, Michal Simek wrote:
> On 07/23/2013 01:32 PM, Sudeep KarkadaNagesha wrote:
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
> 
> Just a note. Zynq is using SCU to get cpu count not DT.
> 
Correct, when I saw that vexpress and zynq were only 2 platforms
setting cpu_present_mask which is unnecessary, I added Zynq last minute
to this series.

Regards,
Sudeep
