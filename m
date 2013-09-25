From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 25 Sep 2013 17:57:53 +0200
Subject: [PATCH 6/7] iommu/arm-smmu: Add module parameter
 arm-smmu=off|force_isolation
In-Reply-To: <20130924154218.GF20774@mudshark.cambridge.arm.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
 <1380035221-11576-7-git-send-email-andreas.herrmann@calxeda.com>
 <20130924154218.GF20774@mudshark.cambridge.arm.com>
Message-ID: <20130925155752.GB20372@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 04:42:18PM +0100, Will Deacon wrote:
> On Tue, Sep 24, 2013 at 04:07:00PM +0100, Andreas Herrmann wrote:
> > +__setup("arm-smmu", arm_smmu_parse_options);
> 
> If this is going to be a common function for IOMMUs, let's instead move the
> command-line parsing out into the generic IOMMU layer, then have an optional
> callback into the low-level IOMMU driver for enabling/disabling it.

Hmm, actually the force-isolation parameters that different IOMMU
drivers implement are for their version of the DMA-API which is not yet
available in the generic IOMMU layer. Unless this changes I think it is
a good idea to keep these parameters close to the actual DMA-API
implementation used and not move them to the IOMMU layer.


	Joerg
