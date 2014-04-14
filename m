From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Apr 2014 07:38:55 +0900
Subject: [PATCH v2 5/6] ARM: shmobile: r8a7740: drop address cells from
 GIC node
In-Reply-To: <1397485098-19198-5-git-send-email-l.stach@pengutronix.de>
References: <1397485098-19198-1-git-send-email-l.stach@pengutronix.de>
 <1397485098-19198-5-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140414223855.GB22518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:18:17PM +0200, Lucas Stach wrote:
> This is likely a copy-and-paste error from the
> ARM GIC documentation, that has already been fixed.
> 
> address-cells should have been set to 0, as with the size
> cells. As having those properties set to 0 is the
> same thing as not specifying them, drop them completely.

Thanks, I have queued this up as a fix for v3.15.

> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v2: split patch, added ack
> ---
>  arch/arm/boot/dts/r8a7740.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 8280884bfa59..2551e9438d35 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -28,7 +28,6 @@
>  	gic: interrupt-controller at c2800000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> -		#address-cells = <1>;
>  		interrupt-controller;
>  		reg = <0xc2800000 0x1000>,
>  		      <0xc2000000 0x1000>;
> -- 
> 1.9.1
> 
