From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 22:31:17 +0100
Subject: [PATCH v5 11/12] ARM: dts: sun6i: Add pinmux settings for mmc1
 to dtsi
In-Reply-To: <1425988764-23618-12-git-send-email-wens@csie.org>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-12-git-send-email-wens@csie.org>
Message-ID: <20150310213117.GG5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 07:59:22PM +0800, Chen-Yu Tsai wrote:
> mmc1 is used to connect to the WiFi chip on the Hummingbird A31.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 92abea20b946..39d87a901b46 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -581,6 +581,14 @@
>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  			};
>  
> +			mmc1_pins_a: mmc1 at 0 {
> +				allwinner,pins = "PG0", "PG1", "PG2", "PG3",
> +						 "PG4", "PG5";
> +				allwinner,function = "mmc1";
> +				allwinner,drive = <2>;
> +				allwinner,pull = <0>;

You should use the defines here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/6843b583/attachment.sig>
