From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jun 2016 15:16:46 +0100
Subject: [PATCH v2 2/7] Docs: dt: add PCI IOMMU map bindings
In-Reply-To: <3a7e47d7b8839ff079568137b5b1b438cfbb44ac.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <3a7e47d7b8839ff079568137b5b1b438cfbb44ac.1464966939.git.robin.murphy@arm.com>
Message-ID: <20160614141644.GI19407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 06:15:37PM +0100, Robin Murphy wrote:
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
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
> 
> v2: +Rob's ack.
> 
>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

This looks great, thanks!

Acked-by: Will Deacon <will.deacon@arm.com>

Will
