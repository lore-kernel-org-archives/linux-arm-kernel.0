From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 23:15:31 +0200
Subject: [PATCH 6/7] ARM: dts: sun6i: Add required ahb1 clock parent and
 rates for dma controller
In-Reply-To: <1410000448-9999-7-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-7-git-send-email-wens@csie.org>
Message-ID: <20140911211531.GN31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 06:47:27PM +0800, Chen-Yu Tsai wrote:
> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 8eb2c6d..1117989 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -317,6 +317,11 @@
>  			clocks = <&ahb1_gates 6>;
>  			resets = <&ahb1_rst 6>;
>  			#dma-cells = <1>;
> +
> +			/* DMA controller requires AHB1 clocked from PLL6 */
> +			assigned-clocks = <&ahb1>;
> +			assigned-clock-parents = <&pll6>;
> +			assigned-clock-rates = <200000000>;

Where did you get that from?

The user manual says that it should be clocked at 600MHz, and I'm not
sure it should be enforced there either.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/fb780bb6/attachment.sig>
