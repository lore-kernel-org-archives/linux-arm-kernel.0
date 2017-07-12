From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jul 2017 16:01:52 -0700
Subject: [PATCH V4 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
In-Reply-To: <20170712225821.GB22780@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-3-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225821.GB22780@codeaurora.org>
Message-ID: <20170712230152.GC22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12, Stephen Boyd wrote:
> On 07/06, Vivek Gautam wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> > 
> > The smmu needs to be functional only when the respective
> > master's using it are active. The device_link feature
> > helps to track such functional dependencies, so that the
> > iommu gets powered when the master device enables itself
> > using pm_runtime. So by adapting the smmu driver for
> > runtime pm, above said dependency can be addressed.
> > 
> > This patch adds the pm runtime/sleep callbacks to the
> > driver and also the functions to parse the smmu clocks
> > from DT and enable them in resume/suspend.
> > 
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > Signed-off-by: Archit Taneja <architt@codeaurora.org>
> > [vivek: Clock rework to loop over clock names data]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> 
> General comment, we have a bulk clk API now, but I guess we
> failed to add the clk_bulk_prepare_enable() API that could be
> used here. Perhaps you can add that API and then use it here to
> reduce lines of code.
> 

Bjorn just sent a patch for that API an hour ago.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
