From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 19 Jul 2018 17:08:31 -0600
Subject: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
In-Reply-To: <20180719175356.14753-2-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org>
Message-ID: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 11:54 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
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
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 00722b533a92..70ca18ae6cb3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -980,6 +980,79 @@
>                         cell-index = <0>;
>                 };
>
> +               apps_smmu: arm,smmu at 15000000 {

iommu at ...

> +                       compatible = "arm,mmu-500";

Really unmodified by QCom? Would be better to have SoC specific compatible.

Rob
