From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 28 Aug 2013 20:45:58 +0100
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130828194558.568303E0A6F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Aug 2013 10:42:22 +0100, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +The ARM architecture, in accordance with the ePAPR, requires the cpus and cpu
> +nodes to be present and contain the properties described below.
> +
> +- cpus node
> +
> +	Description: Container of cpu nodes
> +
> +	The node name must be "cpus".
> +
> +	A cpus node must define the following properties:
> +
> +	- #address-cells
> +		Usage: required
> +		Value type: <u32>
> +
> +		Definition depends on ARM architecture version and
> +		configuration:
> +
> +			# On uniprocessor ARM architectures previous to v7
> +			  value must be 0, since they have no register
> +			  providing CPU identification.

Just clued into this point from the other thread; Don't do this.
Uniprocessor should follow the same rules as 32bit or 64bit for the
value of #address-cells, and cpu nodes should have a reg property, even
if it is merely set to '0'.

g.
