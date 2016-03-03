From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 16:27:34 -0600
Subject: [PATCH 01/12] Docs: dt: add PCI IOMMU map bindings
In-Reply-To: <5bcbc7c0c8825cb0a2ac216bac0ab99722a84618.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
 <5bcbc7c0c8825cb0a2ac216bac0ab99722a84618.1456514380.git.robin.murphy@arm.com>
Message-ID: <20160303222734.GA6287@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:46:10PM +0000, Robin Murphy wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> The existing IOMMU bindings are able to specify the relationship between
> masters and IOMMUs, but they are insufficient for describing the general
> case of hotpluggable busses such as PCI where the set of masters is not
> known until runtime, and the relationship between masters and IOMMUs is
> a property of the integration of the system.
> 
> This patch adds a generic binding for mapping PCI devices to IOMMUs,
> using a new iommu-map property (specific to PCI*) which may be used to
> map devices (identified by their Requester ID) to sideband data for the
> IOMMU which they master through.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

Acked-by: Rob Herring <robh@kernel.org>
