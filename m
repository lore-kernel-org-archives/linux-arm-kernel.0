From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 3 May 2018 16:15:13 +0100
Subject: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
Message-ID: <20180503151513.GD28409@work-enc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 06:31:19PM -0500, Jeremy Linton wrote:
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
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
