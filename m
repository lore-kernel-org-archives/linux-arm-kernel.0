From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Mar 2013 20:26:53 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Fix chip-delay for GoFlex Net
In-Reply-To: <51476198.2080100@gmail.com>
References: <51476198.2080100@gmail.com>
Message-ID: <20130318192653.GZ21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 07:48:56PM +0100, Eric Hutter wrote:
> Hi,
> 
> This fixes "Too few good blocks within range" issues on GoFlex Net
> by setting chip-delay to 40.

Hi Eric

Its a problem seen by a couple of other boards as well, e.g. dns320
and dns325.

Acked-by: Andrew Lunn <andrew@lunn.ch>

> Signed-off-by: Eric Hutter <hutter.eric@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-goflexnet.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts
> b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> index bd83b8f..c3573be 100644
> --- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
> +++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
> @@ -77,6 +77,7 @@
>          };
> 
>          nand at 3000000 {
> +            chip-delay = <40>;
>              status = "okay";
> 
>              partition at 0 {
> -- 
> 1.8.1.4
> 
> 
