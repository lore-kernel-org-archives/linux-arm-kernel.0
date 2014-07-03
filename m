From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 18:43:21 +0100
Subject: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable
 coherent HTW
In-Reply-To: <53B48381.9050707@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-8-git-send-email-ohaugan@codeaurora.org>
 <e64e7ca617d64093bbe5dc7caf9283e1@BL2PR03MB468.namprd03.prod.outlook.com>
 <53B48381.9050707@codeaurora.org>
Message-ID: <20140703174321.GE17372@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:11:13PM +0100, Olav Haugan wrote:
> On 7/1/2014 1:49 AM, Varun Sethi wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> >> bounces at lists.linux-foundation.org] On Behalf Of Olav Haugan
> >> Sent: Monday, June 30, 2014 10:22 PM
> >> To: linux-arm-kernel at lists.infradead.org; iommu at lists.linux-
> >> foundation.org
> >> Cc: linux-arm-msm at vger.kernel.org; will.deacon at arm.com;
> >> thierry.reding at gmail.com; vgandhi at codeaurora.org
> >> Subject: [RFC/PATCH 7/7] iommu-api: Add domain attribute to enable
> >> coherent HTW
> >>
> >> Add a new iommu domain attribute that can be used to enable cache
> >> coherent hardware table walks (HTW) by the SMMU. HTW might be supported
> >> by the SMMU HW but depending on the use case and the usage of the SMMU in
> >> the SoC it might not be always beneficial to always turn on coherent HTW
> >> for all domains/iommu's.
> >>
> > [Sethi Varun-B16395] Why won't you want to use the coherent table walk feature?
> 
> Very good question. We have found that turning on IOMMU coherent HTW is
> not always beneficial to performance (performance either the same or
> slightly worse in some cases). Even if the perf. is the same we would
> like to avoid using precious L2 cache for no benefit to the IOMMU.
> Although our HW supports this feature we don't always want to turn this
> on for a specific use case/domain (bus master).

Could we at least invert the feature flag, please? i.e. you set an attribute
to *disable* coherent walks? I'd also be interested to see some performance
numbers, as the added cacheflushing overhead from non-coherent walks is
going to be non-trivial.

Will
