From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 15:09:58 +0930
Subject: [PATCH 7/7] arm: dts: aspeed: Enable vhub on port A of AST2500 EVB
In-Reply-To: <20180629035106.27181-8-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-8-benh@kernel.crashing.org>
Message-ID: <1531719598.1119558.1441836648.51F03355@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> This is an eval board, it makes sense to enable many
> functions by default. This changes the device-tree to
> set port A to be a USB device and leave port B as a
> host, along with a little comment explaining how to
> change it.
> 
> (the vhub device can only exist on port A on this SoC)
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/
> dts/aspeed-ast2500-evb.dts
> index 2bff1b253842..2375449c02d0 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -80,7 +80,13 @@
>  	};
>  };
>  
> -&ehci0 {
> +/*
> + * Enable port A as device (via the virtual hub) and port B as
> + * host by default on the eval board. This can be easily changed
> + * by replacing the override below with &ehci0 { ... } to enable
> + * host on both ports.
> + */
> +&vhub {
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
> 
