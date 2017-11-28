From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 22:32:53 +0100
Subject: [PATCH 1/1] ARM: dts: sunxi: Update dts for A20-OLinuXino boards
In-Reply-To: <1511784231-6485-1-git-send-email-stefan@olimex.com>
References: <1511784231-6485-1-git-send-email-stefan@olimex.com>
Message-ID: <20171128213252.2bysq3kzubio7cxw@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Nov 27, 2017 at 02:03:51PM +0200, Stefan Mavrodiev wrote:
> There will be option with 16MB flash for the following boards:
> 
>   * A20-OLinuXino-MICRO Rev.K
>   * A20-OLinuXino-LIME Rev.J
>   * A20-OLinuXino-LIME2 Rev.J
>   * A20-SOM-EVB Rev.E
> 
> The used flash chip is Winbond W25Q128FV, which is connected to
> SPI0 port. Since this is optional feature, spi0 node is dissabled
> by default. Also this option is incompatible with NAND flash, so
> they shouldn't be enabled at the same time.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> index 64c8ef9..98b7697 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> @@ -291,6 +291,20 @@
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi0_pins_b>,<&spi0_cs0_pins_b>;
> +	status = "disabled";
> +
> +	flash at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "winbond,w25q128","jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +	};
> +};
> +

So those kind of variations are usually best handled using overlays.

This as become quite convenient using the FIT image rework that
Pantelis did here:
https://lists.denx.de/pipermail/u-boot/2017-June/296879.html

and got merged since 2017.11.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/d60e5b39/attachment-0001.sig>
