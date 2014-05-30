From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 May 2014 10:28:15 -0700
Subject: [PATCH] ARM: qcom: Enable GSBI driver in defconfig
In-Reply-To: <1401380804-16108-1-git-send-email-galak@codeaurora.org>
References: <1401380804-16108-1-git-send-email-galak@codeaurora.org>
Message-ID: <5388BFAF.1050204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/14 09:26, Kumar Gala wrote:
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
>  arch/arm/configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index bfed753..42ebd72 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -131,6 +131,7 @@ CONFIG_RTC_CLASS=y
>  CONFIG_DMADEVICES=y
>  CONFIG_QCOM_BAM_DMA=y
>  CONFIG_STAGING=y
> +CONFIG_QCOM_GSBI=y
>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_MSM_GCC_8660=y
>  CONFIG_MSM_MMCC_8960=y

It would be good to do this in the multi-platform defconfig as well.
Otherwise users of that defconfig (i.e. khilman's boot tester) will
start failing to boot once the DT changes land.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
