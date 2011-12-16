From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 16 Dec 2011 16:21:43 +0100
Subject: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
In-Reply-To: <1323863746-18145-5-git-send-email-rnayak@ti.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
Message-ID: <4EEB6207.9090200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

Just one minor comment if you plan to repost.

On 12/14/2011 12:55 PM, Rajendra Nayak wrote:
> Pass minimal data needed for console boot, from dt, for
> OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> static initialization from generic board file.
>
> Acked-by: Rob Herring<rob.herring@calxeda.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>

Tested-by: Benoit Cousson <b-cousson@ti.com>

>   arch/arm/boot/dts/omap3.dtsi        |   31 +++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/omap4.dtsi        |   28 ++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/board-generic.c |    1 -
>   3 files changed, 59 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index d202bb5..216c331 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -13,6 +13,13 @@
>   / {
>   	compatible = "ti,omap3430", "ti,omap3";
>
> +	aliases {
> +		serial0 =&uart1;
> +		serial1 =&uart2;
> +		serial2 =&uart3;
> +		serial3 =&uart4;
> +	};
> +
>   	cpus {
>   		cpu at 0 {
>   			compatible = "arm,cortex-a8";
> @@ -59,5 +66,29 @@
>   			interrupt-controller;
>   			#interrupt-cells =<1>;
>   		};
> +
> +		uart1: serial at 0x4806a000 {

Could you get rid of the 0x prefix for consistency?
This is applicable for the omap4.dtsi as well.

Thanks,
Benoit
