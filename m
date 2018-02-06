From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 6 Feb 2018 10:10:57 +0100
Subject: [PATCH v2 07/10] ARM: sun8i: h3: add SY8113B regulator used by
 Orange Pi One board
In-Reply-To: <20180206044905.30508-8-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-8-icenowy@aosc.io>
Message-ID: <20180206091057.6uy4fdcfztgmjjlz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 06, 2018 at 12:49:02PM +0800, Icenowy Zheng wrote:
> Orange Pi One board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL6 GPIO is set to output 0
> or 1.3V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
> 
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v2.
> 
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> index 82e5d28cd698..d8250aacfda1 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> @@ -88,6 +88,27 @@
>  			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	reg_sy8113b: gpio-regulator {

There's multiple of them on those boards, so the name and label should
avoid conflicting names (this also applies to your other patches).

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180206/928be13a/attachment.sig>
