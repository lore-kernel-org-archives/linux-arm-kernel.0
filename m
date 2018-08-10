From: dianders@chromium.org (Doug Anderson)
Date: Fri, 10 Aug 2018 15:18:12 -0700
Subject: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
In-Reply-To: <20180719175356.14753-2-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org>
Message-ID: <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Add device node for arm,mmu-500 available on sdm845.
> This MMU-500 with single TCU and multiple TBU architecture
> is shared among all the peripherals except gpu on sdm845.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 6d651f314193..13b50dff440f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -58,3 +58,7 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&apps_smmu {
> +       status = "okay";
> +};

When you spin this patch please put the above in the correct place.
Since "a" sorts alphabetically before "i" then this should be just
before the line:

&i2c10 {

Thanks!

-Doug
