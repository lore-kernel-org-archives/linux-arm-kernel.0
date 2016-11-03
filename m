From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 Nov 2016 18:29:13 +0100
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
In-Reply-To: <a6ded15c-5eea-70b8-61a1-b40873af8699@arm.com>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
 <20161103160006.GS22791@arm.com> <20161103161407.GR3541@8bytes.org>
 <0dbf2665-4292-d49a-b9e7-688bcdf29c6e@arm.com>
 <20161103162943.GS3541@8bytes.org>
 <a6ded15c-5eea-70b8-61a1-b40873af8699@arm.com>
Message-ID: <20161103172913.GT3541@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 04:57:40PM +0000, Robin Murphy wrote:
> But if it is someone else's ops, then all that means is that the SMMU
> driver isn't going to get notified about devices on that bus, or get
> called with them later, so I still don't see where the problem is. If
> there are devices on that bus which the SMMU *is* supposed to be
> managing, then that system can't be supported with the current API anyway.

If another IOMMU is already probed and set its iommu_ops, than there is
no point in probing the smmu anyway, no? The probe function should
return the failed probe in that case and not proceed silently.


	Joerg
