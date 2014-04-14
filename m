From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Apr 2014 07:38:26 +0900
Subject: [PATCH v2 6/6] ARM: shmobile: sh73a0: drop address cells from
 GIC node
In-Reply-To: <1397485098-19198-6-git-send-email-l.stach@pengutronix.de>
References: <1397485098-19198-1-git-send-email-l.stach@pengutronix.de>
 <1397485098-19198-6-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140414223826.GA22518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:18:18PM +0200, Lucas Stach wrote:
> This is likely a copy-and-paste error from the
> ARM GIC documentation, that has already been fixed.
> 
> address-cells should have been set to 0, as with the size
> cells. As having those properties set to 0 is the
> same thing as not specifying them, drop them completely.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v2: split patch, added ack

Thanks, I have queued this up as a fix for v3.15.

> ---
>  arch/arm/boot/dts/sh73a0.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> index b7bd3b9a6753..5ecf552e1c00 100644
> --- a/arch/arm/boot/dts/sh73a0.dtsi
> +++ b/arch/arm/boot/dts/sh73a0.dtsi
> @@ -34,7 +34,6 @@
>  	gic: interrupt-controller at f0001000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> -		#address-cells = <1>;
>  		interrupt-controller;
>  		reg = <0xf0001000 0x1000>,
>  		      <0xf0000100 0x100>;
> -- 
> 1.9.1
> 
