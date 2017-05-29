From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 May 2017 08:59:42 +0200
Subject: [PATCH 1/3] ARM: sun8i: v3s: add PWM device node
In-Reply-To: <20170524121320.4171-1-icenowy@aosc.io>
References: <20170524121320.4171-1-icenowy@aosc.io>
Message-ID: <20170529065942.gho4kjgzsv4lfnda@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 24, 2017 at 08:13:18PM +0800, Icenowy Zheng wrote:
> As we have already the support for the PWM controller on V3s SoC, add
> its device node in the SoC's DTSI file.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index a49ebef53c91..bb080c4bd22c 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -255,6 +255,14 @@
>  			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		pwm: pwm at 1c21400 {
> +			compatible = "allwinner,sun7i-a20-pwm";

You need to have a v3s compatible here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170529/9db4ece3/attachment.sig>
