From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 26 Jul 2017 20:17:27 +0530
Subject: [PATCH v2 0/5] clk: qcom: gdsc: Add support for clk control
In-Reply-To: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <CAFp+6iFZw3B4N5kj0Ff_4oCfRqwfdMSUwdcfpbEtnWjCCrZffg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 10:18 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> This series allows clocks associated with GDSCs to be controlled
> along with the powerdomains. To start with, some of the mmagic
> clocks are assocaited with the mmagic gdscs on msm8996 so the
> devices in these mmagic domains (vidc, mdss, their smmu instances etc)
> don't have to put these in their resp. DT bindings.
>
> changes in v2:
> * Fixed review comments from Stan
> * Added mmagic clocks needed by gpu

Tested the series on db820c with necessary iommu and display/gpu
patches.

Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>


Regards
Vivek

>
> Rajendra Nayak (5):
>   arm64: qcom: Select PM_GENERIC_DOMAINS
>   clk: Add clk_hw_get_clk() helper API to be used by clk providers
>   clk: qcom: gdsc: Add support to control associated clks
>   clk: qcom: gcc-msm8996: Mark gcc_mmss_noc_cfg_ahb_clk as a critical
>     clock
>   clk: qcom: mmcc-8996: Associate all mmagic clks with mmagic gdscs
>
>  arch/arm64/Kconfig.platforms    |  2 ++
>  drivers/clk/clk.c               | 39 +++++++++++++++++++++++++++
>  drivers/clk/qcom/gcc-msm8996.c  |  2 +-
>  drivers/clk/qcom/gdsc.c         | 60 +++++++++++++++++++++++++++++++++++++++--
>  drivers/clk/qcom/gdsc.h         |  8 ++++++
>  drivers/clk/qcom/mmcc-msm8996.c | 26 ++++++++++++++++++
>  include/linux/clk-provider.h    |  5 ++++
>  7 files changed, 139 insertions(+), 3 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
