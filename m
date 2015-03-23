From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 23 Mar 2015 15:23:41 +0100
Subject: [PATCH v2 1/1] iommu/arm-smmu: fix ARM_SMMU_FEAT_TRANS_OPS
 condition
In-Reply-To: <20150304183258.GN17250@arm.com>
References: <1425484266-5449-1-git-send-email-b.reynal@virtualopensystems.com>
 <20150304183258.GN17250@arm.com>
Message-ID: <20150323142340.GA2226@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 06:32:58PM +0000, Will Deacon wrote:
> > -	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
> > +	if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
> >  		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
> >  		dev_notice(smmu->dev, "\taddress translation ops\n");
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Sorry Joerg, but this is the latest in the drip of ARM SMMU fixes for
> 4.0! Please pick it up with the rest.

Applied to iommu/fixes, thanks.
