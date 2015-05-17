From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 May 2015 16:54:26 +0200
Subject: [RFC 4/7] ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
In-Reply-To: <1431583811-25780-5-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-5-git-send-email-wens@csie.org>
Message-ID: <20150517145426.GL4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:10:08PM +0800, Chen-Yu Tsai wrote:
> The PRCM is a collection of clock controls, reset controls, and various
> power switches/gates. Some of these can be independently listed and
> supported, while a number of CPU related ones are used in tandem with
> CPUCFG for SMP bringup and CPU hotplugging.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index c45735398f6a..1507bd2a88f0 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -797,6 +797,11 @@
>  			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		prcm at 01700000 {
> +			compatible = "allwinner,sun9i-a80-prcm";
> +			reg = <0x08001400 0x200>;
> +		};
> +

The unit address doesn't match the content of the reg property.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150517/5e709696/attachment.sig>
