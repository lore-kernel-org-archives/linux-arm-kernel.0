From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 28 Jun 2017 12:00:16 -0600
Subject: [PATCH v2 02/12] arm64: dts: juno: Use the new coresight
 replicator string
In-Reply-To: <1498490576-1350-3-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
 <1498490576-1350-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CANLsYkwYttnpVgvGVFThqN0F+sHj2up61gk3itBAbhW92TTSgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2017 at 09:22, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> Use the new compatible for ATB programmable replicator in Juno.
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index bfe7d68..c82c706 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -373,7 +373,7 @@
>         };
>
>         replicator at 20120000 {
> -               compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +               compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>                 reg = <0 0x20120000 0 0x1000>;

Since we are getting rid of the qcom string entirely please fix it in
the msm DT files as well.

Thanks,
Mathieu

>
>                 clocks = <&soc_smc50mhz>;
> --
> 2.7.5
>
