From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jan 2018 09:01:39 +0100
Subject: [PATCH v2] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
In-Reply-To: <1515748144-25204-1-git-send-email-jagan@amarulasolutions.com>
References: <1515748144-25204-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180115080139.k2vrczo3hnvdt3df@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 12, 2018 at 02:39:04PM +0530, Jagan Teki wrote:
> Add usb otg support for orangepi-zero-plus2 board:
> - Add usb_otg node with dr_mode as 'otg'
> - USB0-IDDET connected to PA21
> - VBUS connected through DCIN which always on
> 
> Tested mass storage function.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Change dr_mode to peripheral
> 
>  .../dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index af43533..6511190 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> @@ -73,6 +73,10 @@
>  	};
>  };
>  
> +&ehci0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins_a>;
> @@ -111,6 +115,10 @@
>  	status = "okay";
>  };
>  
> +&ohci0 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> @@ -122,3 +130,13 @@
>  	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>  	status = "okay";
>  };
> +
> +&usb_otg {
> +	dr_mode = "peripheral";

If VBUS is always on, this can only operate safely in host mode, not
peripheral.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180115/b1e2668a/attachment-0001.sig>
