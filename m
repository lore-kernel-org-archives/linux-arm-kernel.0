From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Mar 2018 12:06:15 +0000
Subject: [PATCH v7 00/13] Support PPTT for ARM64
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
Message-ID: <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 28/02/18 22:06, Jeremy Linton wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the physical_id to the
> PPTT node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the
> system expects. To avoid inverted scheduler domains we then
> set the MC domain equal to the largest cache within the socket
> below the NUMA domain.
> 
I remember reviewing and acknowledging most of the cacheinfo stuff with
couple of minor suggestions for v6. I don't see any Acked-by tags in
this series and don't know if I need to review/ack any more cacheinfo
related patches.

-- 
Regards,
Sudeep
