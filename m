From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 22 Jan 2018 20:45:26 -0800
Subject: [RFC PATCH] Documentation: DT: arm: Add topology property to
 define package boundaries
In-Reply-To: <20180122171534.7681-1-lorenzo.pieralisi@arm.com>
References: <20180122171534.7681-1-lorenzo.pieralisi@arm.com>
Message-ID: <b58b99e8-dfa3-40d6-aba2-bc1f96170fd6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/18 09:15, Lorenzo Pieralisi wrote:
> The current ARM DT topology description provides the operating system
> with a topological view of the system that is based on leaf nodes
> representing either cores or threads (in an SMT system) and a
> hierarchical set of cluster nodes that creates a hierarchical topology
> view of how those cores and threads are grouped.
> 
> As opposed to the ACPI topology description ([1], PPTT table), this
> hierarchical representation of clusters does not allow to describe what
> topology level actually represents the physical package boundary, which
> is a key piece of information to be used by an operating system to
> optimize resource allocation and scheduling.
> 
> Define an optional, backward compatible boolean property for cluster
> nodes that, by reusing the ACPI nomenclature, add to the ARM DT
> topological description a binding to define what cluster level
> represents a physical package boundary.
> 
> [1] http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/topology.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/arm/topology.txt
> index de9eb0486630..8e78d76b0671 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/arm/topology.txt
> @@ -109,6 +109,15 @@ Bindings for cluster/cpu/thread nodes are defined as follows:
>  	The cluster node name must be "clusterN" as described in 2.1 above.
>  	A cluster node can not be a leaf node.
>  
> +	Properties for cluster nodes:
> +
> +	- physical-package
> +		Usage: optional
> +		Value type: <empty>
> +		Definition: if present the cluster node represents the
> +			    boundary of a physical package, whether socketed
> +			    or surface mounted.

I don't know how to interpret this.  Is the node with this property inside
or outside the boundary?  If I had to guess, I would guess inside.  A few
extra words to clarify this please.


> +
>  	A cluster node's child nodes must be:
>  
>  	- one or more cluster nodes; or
> 
