From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 26 Feb 2014 18:23:15 +0300
Subject: [PATCH v3 07/20] ARM: shmobile: marzen: Reference clocks
In-Reply-To: <1393400016-23433-8-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <530E06E3.9070901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/26/2014 10:33 AM, Simon Horman wrote:

> Reference clocks using a "clocks" property in all nodes corresponding to
> devices that require a clock: that is, the lan0 node.

    Simon, "lan0" (should be "ethernet" BTW) is the SMC chip, it can't use 
Ether clock.

> Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v3
> * New
> ---
>   arch/arm/boot/dts/r8a7779-marzen.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
> index 2c727cd..30f57e9 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -41,6 +41,7 @@
>   		reg = <0x18000000 0x100>;
>   		pinctrl-0 = <&lan0_pins>;
>   		pinctrl-names = "default";
> +		clocks = <&mstp1_clks R8A7779_CLK_ETHER>;
>
>   		phy-mode = "mii";
>   		interrupt-parent = <&irqpin0>;

WBR, Sergei
