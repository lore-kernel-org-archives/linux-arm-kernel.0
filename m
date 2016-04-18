From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Apr 2016 09:45:09 +0100
Subject: [PATCH] arm64: dts: uniphier: add /memreserve/ for spin-table
 release address
In-Reply-To: <1460743138-17768-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460743138-17768-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160418084508.GA21438@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 02:58:58AM +0900, Masahiro Yamada wrote:
> As Documentation/arm64/booting.txt says, the cpu-release-addr
> location should be reserved.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> index 651c9d9..90909d2 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
> @@ -42,6 +42,8 @@
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> +/memreserve/ 0x80000100 0x00000008;
> +

Please add a comment above the memreserve to mention what it is
protecting. That helps to avoid having this cargo-culted to cases where
it is not needed.

I take it that the code for the spin-table is not in RAM, and does not
need to be protected similarly?

Assuming so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  / {
>  	compatible = "socionext,ph1-ld20";
>  	#address-cells = <2>;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
