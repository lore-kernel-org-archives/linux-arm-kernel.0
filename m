From: joro@8bytes.org (joro at 8bytes.org)
Date: Tue, 3 Feb 2015 18:54:15 +0100
Subject: [PATCH] iommu: arm-smmu: avoid build warning
In-Reply-To: <20150202102048.GB30699@arm.com>
References: <1754709.y30A9Ie4hF@wuerfel>
 <20150202102048.GB30699@arm.com>
Message-ID: <20150203175415.GB29585@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 10:20:49AM +0000, Will Deacon wrote:
> On Fri, Jan 30, 2015 at 09:55:55PM +0000, Arnd Bergmann wrote:
> > -		reg = (iova & ~0xfff) >> 32;
> > +		reg = ((u64)iova & ~0xfff) >> 32;
> >  		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
> >  	}
> 
> Thanks, Arnd.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Joerg, could you pick this one up directly please? I don't have any other
> ARM SMMU fixes queued at the moment.

Done, thanks.
