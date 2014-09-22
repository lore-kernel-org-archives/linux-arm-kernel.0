From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 22 Sep 2014 12:22:26 +0300
Subject: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20140922091934.GH1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-8-git-send-email-will.deacon@arm.com>
 <20140922091934.GH1470@ulmo>
Message-ID: <5834409.n6nGqbdKJT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 11:19:35 Thierry Reding wrote:
> On Fri, Sep 12, 2014 at 05:34:55PM +0100, Will Deacon wrote:
> [...]
> 
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64
> > size) +{
> > +	struct dma_iommu_mapping *mapping;
> > +
> > +	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
> 
> If I understand correctly this will be called for each device that has
> an IOMMU master interface and will end up creating a new mapping for
> each of the devices. Each of these mappings will translate to a domain
> in the IOMMU API, which in turn is a separate address space.
> 
> How do you envision to support use-cases where a set of devices need to
> share a single domain? This is needed for example in DRM where SoCs
> often have a set of hardware blocks (each with its own master interface)
> that compose the display device. On Tegra for example there are two
> display controllers that need access to the same IOVA domain so that
> they can scan out framebuffers.

Or simply for IOMMUs that serve multiple masters and support a single domain 
only.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/c29940d0/attachment.sig>
