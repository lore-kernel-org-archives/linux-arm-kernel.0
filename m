From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 6 Mar 2018 16:43:55 +0000
Subject: [PATCH v7 02/13] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <20180228220619.6992-3-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-3-jeremy.linton@arm.com>
Message-ID: <67bdb642-292c-598a-496f-9d186c8a6705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 22:06, Jeremy Linton wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
> 
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
