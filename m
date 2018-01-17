From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 17 Jan 2018 15:27:20 +0100
Subject: [PATCH 1/2] iommu/msm: Claim bus ops on probe
In-Reply-To: <fc884e48-bf80-23a7-8275-209950e0ef34@arm.com>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
 <20180117133331.vidtyduiu7zr3fwc@8bytes.org>
 <bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
 <20180117135356.GQ28161@8bytes.org>
 <fc884e48-bf80-23a7-8275-209950e0ef34@arm.com>
Message-ID: <20180117142720.GT28161@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 02:05:21PM +0000, Robin Murphy wrote:
> The IOMMU_OF_DECLARE() in ipmmu-vmsa.c added in 4.15 is missed by the
> prototype change in (4.14-based) v1 2/2 - by applying v2 2/3 on top of the
> two v1 patches you will end up with an extra NULL argument there which will
> then fail to compile. v2 3/3 supersedes v1 2/2 by removing that one as well.
> This is entirely my fault for hacking out some quick patches on top of
> unrelated development work instead of creating a fresh branch...

Okay, I see. So I removed the two patches from arm/msm and the one patch
from arm/renesas and applied all 3 patches from v2 to the core branch
instead.

Thanks,

	Joerg
