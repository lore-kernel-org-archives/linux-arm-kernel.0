From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Aug 2018 12:40:09 +0100
Subject: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
In-Reply-To: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Message-ID: <20180814114009.GF28664@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
> errata [1] because of which the TCU cache look ups are stalled during
> invalidation cycle. This is mitigated by serializing all the invalidation
> requests coming to the smmu.

How does this implementation differ from the one supported by qcom_iommu.c?
I notice you're adding firmware hooks here, which we avoided by having the
extra driver. Please help me understand which devices exist, how they
differ, and which drivers are intended to support them!

Also -- you didn't CC all the maintainers for the firmware bits, so adding
Andy here for that, and Rob for the previous question.

Thanks,

Will
