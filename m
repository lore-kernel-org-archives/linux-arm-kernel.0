From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 09:58:33 +0200
Subject: [PATCH 3/3] ARM: sun8i: a83t: Add device node for PRCM
In-Reply-To: <20170526080025.28532-4-wens@csie.org>
References: <20170526080025.28532-1-wens@csie.org>
 <20170526080025.28532-4-wens@csie.org>
Message-ID: <20170529075833.6dc4uqwa6uxtzs5y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 26, 2017 at 04:00:25PM +0800, Chen-Yu Tsai wrote:
> The A83T's PRCM has the same set of clocks and resets as the A64.
> However, a few dividers are different. And due to the lack of a low
> speed 32.768 kHz oscillator, a few of the clock parents are different.
> 
> The PRCM also has controls for various power domains. These are not
> supported yet, neither in software nor in the device tree binding.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 1dc4cfe81534..8089f36deeff 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -270,5 +270,14 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
> +
> +		r_ccu: clock at 1f01400 {
> +			compatible = "allwinner,sun8i-a83t-r-ccu";
> +			reg = <0x01f01400 0x400>;
> +			clocks = <&osc24M>, <&osc16Md512>, <&osc16M>;

I applied patches 1 and 2, but that made me realise that the
pll-periph0 is also a parent and should be listed there.

Can you send a patch adjusting the binding documentation so that we
can have it in time for 4.12, and patches for the A64 / H3 DTSs ?

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/ab4e8ab1/attachment-0001.sig>
