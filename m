From: robertcnelson@gmail.com (Robert Nelson)
Date: Fri, 21 Oct 2016 15:47:58 -0500
Subject: [PATCH 5/7] ARM: dts: am335x: Add the charger interrupt
In-Reply-To: <20161021140106.21531-6-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
 <20161021140106.21531-6-woogyom.kim@gmail.com>
Message-ID: <CAOCHtYgBTq0a1FAMQJb5VoLPWBHYkF3rH_Km6U9u6ep=8ApZuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 9:01 AM, Milo Kim <woogyom.kim@gmail.com> wrote:
> This enables the charger driver gets corresponding IRQ number by using
> platform_get_irq_byname() helper.
>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 25303d9..cec9d91 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -6,6 +6,8 @@
>   * published by the Free Software Foundation.
>   */
>
> +#include <dt-bindings/mfd/tps65217.h>

^ this hasn't been posted nor pushed to mainline yet.. ;)

> +
>  / {
>         cpus {
>                 cpu at 0 {
> @@ -316,6 +318,12 @@
>
>         ti,pmic-shutdown-controller;
>
> +       charger {
> +               interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
> +               interrupts-names = "AC", "USB";
> +               status = "okay";
> +       };
> +
>         regulators {
>                 dcdc1_reg: regulator at 0 {
>                         regulator-name = "vdds_dpr";
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Robert Nelson
https://rcn-ee.com/
