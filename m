From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 20 Mar 2015 17:24:18 +0800
Subject: [PATCH 00/15] iommu: Move domain allocation into drivers
In-Reply-To: <1422316305-19216-1-git-send-email-joro@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Message-ID: <1426843458.23931.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 00:51 +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Hi,
> 
> here is patch-set to replace the existing domain_init and
> domain_destroy iommu-ops with the new domain_alloc and
> domain_free callbacks
> 
> The new callbacks move the allocation of iommu domains into
> the iommu driver, allowing them to put a generic
> iommu_domain struct into their own domain struct. This makes
> domain handling in the drivers more cache efficient and
> prepares the introduction of default domains in another
> patch-set.

Hi Joerg,

What's the status of this patchset?
While porting MTK IOMMU driver[1], we need to use a global variable
because we need to do dma_alloc_coherent in our domain_init. I think we
can remove that global variable if we base on this series.

Joe.C

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328461.html
