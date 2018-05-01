From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 1 May 2018 15:46:22 +0100
Subject: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
Message-ID: <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id and core_id by assuming
> certain levels of the PPTT tree correspond to those concepts.
> The package_id is flagged in the tree and can be found by calling
> find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

[..]

> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>  	 * Discard anything that was parsed if we hit an error so we
>  	 * don't use partial information.
>  	 */
> -	if (of_have_populated_dt() && parse_dt_topology())
> +	if ((!acpi_disabled) && parse_acpi_topology())

[nit] not sure if extra () is need above, but I am fine either way.

-- 
Regards,
Sudeep
