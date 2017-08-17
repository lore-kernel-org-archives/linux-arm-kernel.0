From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Aug 2017 15:36:50 +0100
Subject: [PATCH 0/5] arm-smmu: performance optimization
In-Reply-To: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20170817143650.GB30338@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thunder, Nate, Robin,

On Mon, Jun 26, 2017 at 09:38:45PM +0800, Zhen Lei wrote:
> I described the optimization more detail in patch 1 and 2, and patch 3-5 are
> the implementation on arm-smmu/arm-smmu-v3 of patch 2.
> 
> Patch 1 is v2. In v1, I directly replaced writel with writel_relaxed in
> queue_inc_prod. But Robin figured that it may lead SMMU consume stale
> memory contents. I thought more than 3 whole days and got this one.
> 
> This patchset is based on Robin Murphy's [PATCH v2 0/8] io-pgtable lock removal.

For the time being, I think we should focus on the new TLB flushing
interface posted by Joerg:

http://lkml.kernel.org/r/1502974596-23835-1-git-send-email-joro at 8bytes.org

which looks like it can give us most of the benefits of this series. Once
we've got that, we can see what's left in the way of performance and focus
on the cmdq batching separately (because I'm still not convinced about it).

Thanks,

Will
