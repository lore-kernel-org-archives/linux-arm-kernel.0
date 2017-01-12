From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jan 2017 17:20:19 +0000
Subject: [PATCH] iommu/arm-smmu-v3: limit use of 2-level stream tables
In-Reply-To: <1484077633-18376-1-git-send-email-nwatters@codeaurora.org>
References: <20161220102209.GC10132@arm.com>
 <1484077633-18376-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <20170112172019.GI13843@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 02:47:13PM -0500, Nate Watterson wrote:
> In the current arm-smmu-v3 driver, all smmus that support 2-level
> stream tables are being forced to use them. This is suboptimal for
> smmus that support fewer stream id bits than would fill in a single
> second level table. This patch limits the use of 2-level tables to
> smmus that both support the feature and whose first level table can
> possibly contain more than a single entry.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Thanks Nate, I'll queue this for 4.11. Sorry for messing you about before.

Will
