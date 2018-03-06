From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 6 Mar 2018 17:39:24 +0000
Subject: [PATCH v7 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
In-Reply-To: <20180228220619.6992-6-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-6-jeremy.linton@arm.com>
Message-ID: <56b96eaa-4c9d-7661-1ed0-df34c9c1e636@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 22:06, Jeremy Linton wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
> 
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
> 
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
> 
> 
The more I look at the ACPI table parsing code, I get more questions
every time :). So I just skimmed through it this time. Not sure why
ACPI_PTR_* is not used elsewhere in drivers/acpi/tables.c

Anyways for cacheinfo part of this file:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
