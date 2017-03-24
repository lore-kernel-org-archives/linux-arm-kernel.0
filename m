From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Mar 2017 16:46:14 +0100
Subject: [PATCH v2 1/1] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
In-Reply-To: <20170323212444.20685-2-jelle@vdwaa.nl>
References: <20170323212444.20685-1-jelle@vdwaa.nl>
 <20170323212444.20685-2-jelle@vdwaa.nl>
Message-ID: <20170324154614.mjfl6dnvwddp364b@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 23, 2017 at 10:24:44PM +0100, Jelle van der Waa wrote:
> Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.
> 
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> index 3ba081c1f555..457a28e56514 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
> @@ -73,6 +73,13 @@
>  			gpios = <&pio 0 10 GPIO_ACTIVE_HIGH>; /* PA10 */
>  		};
>  	};
> +
> +	wifi-pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi-en-nanopi-neo-air>;

Could you please drop that pinctrl group for that GPIO? It will help
us prevent a bug in the future in the pinctrl driver that allows two
GPIO users to claim the same pin.

Unfortunately, that will require removing all those pinctrl properties
for the GPIOs, so we'd better not introduce them in the first place :)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/ebfdb4ff/attachment-0001.sig>
