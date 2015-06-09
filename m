From: dann.frazier@canonical.com (Dann Frazier)
Date: Tue, 9 Jun 2015 09:32:45 -0600
Subject: [PATCH 1/2 RESEND] power: reset: Add syscon reboot device node
 for APM X-Gene platform
In-Reply-To: <1433272747-27114-2-git-send-email-ttnguyen@apm.com>
References: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
 <1433272747-27114-2-git-send-email-ttnguyen@apm.com>
Message-ID: <CALdTtnuy91beqWQiAtr1HFt3o9=vK70zLig2=ckywD=cu8smwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 1:19 PM, Tai Nguyen <ttnguyen@apm.com> wrote:
> This patch adds syscon reboot device node to support reboot feature on APM X-Gene platform

Tested-by: dann frazier <dann.frazier@canonical.com>

> Signed-off-by: Feng Kan  <fkan@apm.com>
> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
> ---
>  arch/arm64/boot/dts/apm/apm-storm.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index c8d3e0e..16efcf7 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -710,5 +710,17 @@
>                         dma-coherent;
>                         clocks = <&dmaclk 0>;
>                 };
> +
> +               scu: system-clk-controller at 17000000 {
> +                       compatible = "apm,xgene-scu","syscon";
> +                       reg = <0x0 0x17000000 0x0 0x400>;
> +               };
> +
> +               reboot: reboot at 17000014 {
> +                       compatible = "syscon-reboot";
> +                       regmap = <&scu>;
> +                       offset = <0x14>;
> +                       mask = <0x1>;
> +               };
>         };
>  };
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
