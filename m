From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 19 Dec 2015 00:51:26 +0300
Subject: [PATCH 1/3] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1450474676-10210-1-git-send-email-jonmason@broadcom.com>
References: <1450474676-10210-1-git-send-email-jonmason@broadcom.com>
Message-ID: <56747FDE.9040308@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/19/2015 12:37 AM, Jon Mason wrote:

> Add support for the ARM TWD Watchdog to the bcm5301x device tree.  The
> ARM TWD timer allocated the register space for the WDT, so this patch
> necessitated shrinking that.  Also, the GIC masks were added for these.
>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>   arch/arm/boot/dts/bcm5301x.dtsi | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 65a1309..c31fafe 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -66,10 +66,19 @@
>   			clocks = <&periph_clk>;
>   		};
>
> -		local-timer at 20600 {
> +		twd-timer at 20600 {

    Please just "timer". The node names should be very generic, according to 
the ePAPR standard.

>   			compatible = "arm,cortex-a9-twd-timer";
> -			reg = <0x20600 0x100>;
> -			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x20600 0x20>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +						  IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&periph_clk>;
> +		};
> +
> +		twd-watchdog at 20620 {

    Please, just "watchdog".

MBR, Sergei
