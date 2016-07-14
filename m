From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Jul 2016 14:31:07 +0100
Subject: [PATCH v2] iommu/arm-smmu-v3: limit use of 2-level stream tables
In-Reply-To: <1468347560-29924-1-git-send-email-nwatters@codeaurora.org>
References: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
 <1468347560-29924-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20160714133107.GK29455@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 02:19:20PM -0400, Nate Watterson wrote:
> In the current arm-smmu-v3 driver, all smmus that support 2-level
> stream tables are being forced to use them. This is suboptimal for
> smmus that support fewer stream id bits than would fill in a single
> second level table. This patch limits the use of 2-level tables to
> smmus that both support the feature and whose first level table can
> possibly contain more than a single entry.

Just to be clear, what exactly are you seeing as being suboptimal here?
Is it the memory wastage from overallocating the L2 table, or something
more?

if it's just the memory allocation, I'd sooner restrict the span field
in the L1 desc.

Will
