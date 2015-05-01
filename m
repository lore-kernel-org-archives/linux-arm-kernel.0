From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 01 May 2015 14:44:45 +0100
Subject: [PATCH 2/2] ARM: vexpress: Add interrupt-affinity
In-Reply-To: <20150430175541.GL15254@pengutronix.de>
References: <1430416448-25203-1-git-send-email-r.schwebel@pengutronix.de>
 <20150430175541.GL15254@pengutronix.de>
Message-ID: <5543834D.6040506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/04/15 18:55, Robert Schwebel wrote:
> On Thu, Apr 30, 2015 at 07:54:08PM +0200, Robert Schwebel wrote:
>> Without this property, we get this boot warning:
>>
>> [    0.459361] CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]
>>
>> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

May be you can also mention the commit introducing the change in the log
something like:

"
Commit 9fd85eb502a7 ("ARM: pmu: add support for interrupt-affinity
property") added optional optional "interrupt-affinity" property, to
specify CPU affinity for each SPI listed in the interrupts property.

Without this property, we get this boot warning:
	CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]

This patch add interrupt-affinity to the PMU node in CA9x4 device tree.
"

Otherwise:
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

>
> However, with this patch applied, the messages above disappear, but I
> still get this:
>
> [    0.495280] CPU PMU: Failed to find logical CPU for cpu
>
> on a kernel configured with CONFIG_SMP=n. nr_cpu_ids is 1 there, while
> the loop still loops over all available cores. Ths makes the logic fail.

This is a different issue. You must also see warning from devtree.c when
parsing CPUs complaining about more CPU nodes found in DT. IIUC the
functionality still works fine.

Regards,
Sudeep
