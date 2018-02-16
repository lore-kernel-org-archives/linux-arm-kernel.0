From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 16 Feb 2018 15:21:56 +1030
Subject: [PATCH 3/6] ARM: dts: aspeed-g5: Update LPC node
In-Reply-To: <20180212074325.23436-4-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
 <20180212074325.23436-4-joel@jms.id.au>
Message-ID: <1518756716.10440.25.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-02-12 at 18:13 +1030, Joel Stanley wrote:
> This addresses some differences between the G5 and G4 LPC nodes that
> make them hard to compare. There is no functional change.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 18185484a224..e0b6803f6845 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -264,7 +264,7 @@
>  
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				ranges = <0 0x1e789000 0x1000>;
> +				ranges = <0x0 0x1e789000 0x1000>;
>  
>  				lpc_bmc: lpc-bmc at 0 {
>  					compatible = "aspeed,ast2500-lpc-bmc";
> @@ -274,12 +274,11 @@
>  				lpc_host: lpc-host at 80 {
>  					compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
>  					reg = <0x80 0x1e0>;
> +					reg-io-width = <4>;
>  
>  					#address-cells = <1>;
>  					#size-cells = <1>;
> -					ranges = <0 0x80 0x1e0>;
> -
> -					reg-io-width = <4>;
> +					ranges = <0x0 0x80 0x1e0>;
>  
>  					lpc_ctrl: lpc-ctrl at 0 {
>  						compatible = "aspeed,ast2500-lpc-ctrl";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180216/9d534d0f/attachment.sig>
