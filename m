From: vkale@apm.com (Vinayak Kale)
Date: Mon, 17 Mar 2014 17:03:22 +0530
Subject: arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <1395048095-32745-1-git-send-email-vkale@apm.com>
References: <1395048095-32745-1-git-send-email-vkale@apm.com>
Message-ID: <CAPrCYkfDTrGO0oxXzqE3KwV0n85K4n6vtK2bh8Qhu=2MShBYqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Somehow the "[PATCH]" string in the subject is missing, I'll see
what's wrong and correct the same in next version.

Thanks
-Vinayak

On Mon, Mar 17, 2014 at 2:51 PM, Vinayak Kale <vkale@apm.com> wrote:
> This patch adds the PMU device tree node for APM X-Gene Storm SOC.
>
> Please note that this patch has dependancy on a GIC driver patch [1] which is
> yet to be approved by maintainers.
>
> [1]- https://lkml.org/lkml/2014/2/27/605
> (irqchip:gic: change access of gicc_ctrl register to read modify write)
>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  arch/arm64/boot/dts/apm-storm.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index d37d736..587348d 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -97,6 +97,11 @@
>                 clock-frequency = <50000000>;
>         };
>
> +       pmu {
> +               compatible = "arm,armv8-pmuv3";
> +               interrupts = <1 12 0xff04>;
> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 #address-cells = <2>;
> --
> 1.8.2.1
>
