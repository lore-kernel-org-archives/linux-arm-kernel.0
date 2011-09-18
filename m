From: santosh.shilimkar@ti.com (Santosh)
Date: Sun, 18 Sep 2011 14:17:05 +0530
Subject: [PATCH 23/25] OMAP4: PM: Add CPUidle support
In-Reply-To: <87k498pejf.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-24-git-send-email-santosh.shilimkar@ti.com>
	<87k498pejf.fsf@ti.com>
Message-ID: <4E75B009.5040308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 September 2011 11:15 PM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Add OMAP4 CPUIDLE support. CPU1 is left with defualt idle and
>> the low power state for it is managed via cpu-hotplug.
>>
>> This patch adds MPUSS low power states in cpuidle.
>>
>> 	C1 - CPU0 ON + CPU1 ON + MPU ON
>> 	C2 - CPU0 OFF + CPU1 OFF + MPU CSWR
>> 	C3 - CPU0 OFF + CPU1 OFF + MPU OSWR
>>
>> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
>> anymore just like CORE power domain. The deepest state supported is OSWr.
>> Ofcourse when MPUSS and CORE PD transitions to OSWR along with device
>> off mode, even the memory contemts are lost which is as good as
>> the PD off state.
>>
>> On OMAP4 because of hardware constraints, no low power states are
>> targeted when both CPUs are online and in SMP mode. The low power
>> states are attempted only when secondary CPU gets offline to OFF
>> through hotplug infrastructure.
>>
>> Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
>> C-state latency profiling.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
> 
> A handful of minor comments below...
> 
Will take care of them.

Regards
Santosh
