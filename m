From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Jul 2016 08:50:42 +0200
Subject: [PATCH v5 7/7] ARM: dts: sun9i: Switch to the AC100 RTC clock
 outputs for osc32k
In-Reply-To: <1467988422-17934-8-git-send-email-wens@csie.org>
References: <1467988422-17934-1-git-send-email-wens@csie.org>
 <1467988422-17934-8-git-send-email-wens@csie.org>
Message-ID: <20160711065042.GC4589@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 08, 2016 at 10:33:42PM +0800, Chen-Yu Tsai wrote:
> The 32.768 kHz clock inside the A80 SoC is fed from an external source,
> typically the AC100 RTC module.
> 
> Make the osc32k placeholder a fixed-factor clock so board dts files can
> specify its source.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v4: none
> Changes since v3: none
> Changes since v2: none
> Changes since v1: none
> ---
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 5 +++++
>  arch/arm/boot/dts/sun9i-a80-optimus.dts     | 5 +++++
>  arch/arm/boot/dts/sun9i-a80.dtsi            | 9 +++------
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> index cf2f4b72a841..04b014603659 100644
> --- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> @@ -103,6 +103,11 @@
>  	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
>  };
>  
> +&osc32k {
> +	/* osc32k input is from AC100 */
> +	clocks = <&ac100_rtc 0>;
> +};
> +

I'm guessing that an unresolved dependency when the driver has not
loaded yet, or is not even compiled ?

How is it working then?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160711/a5567557/attachment-0001.sig>
