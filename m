From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 09:31:50 -0500
Subject: [PATCH 1/3] Documentation: dt: Add TI-SCI PM Domains
In-Reply-To: <20160819235653.26355-2-nm@ti.com>
References: <20160819235653.26355-1-nm@ti.com>
 <20160819235653.26355-2-nm@ti.com>
Message-ID: <20160902143150.GA32012@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 06:56:51PM -0500, Nishanth Menon wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow each PD, which will be
> created one per device, to be managed over the TI-SCI protocol.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 58 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> new file mode 100644
> index 000000000000..059a5d71d692
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> @@ -0,0 +1,58 @@
> +Texas Instruments TI-SCI Generic Power Domain
> +---------------------------------------------
> +
> +Some TI SoCs contain a system controller (like the PMMC, etc...) that are
> +responsible for control the state of the IPs that are present. Communication
> +between the host processor running an OS and the system controller happens
> +through a protocol known as TI-SCI[1]. This pm domain implementation plugs into
> +the generic pm domain framework and makes use of the TI SCI protocol power on
> +and off each device when needed.
> +
> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +
> +PM Domains Nodes
> +================
> +The PM domains node represents the global PM domain managed by the PMMC,
> +which in this case is one cell implementation as documented by the generic
> +PM domain bindings in
> +Documentation/devicetree/bindings/power/power_domain.txt.
> +
> +Required Properties:
> +--------------------
> +- compatible: should be "ti,sci-pm-domains"
> +- #power-domain-cells: Must be 1 so that an offset can be provided in each
> +		       device node.
> +- ti,sci: Phandle to the TI SCI device to use for managing the devices

How about just making this a child node of the SCI device?

Rob
