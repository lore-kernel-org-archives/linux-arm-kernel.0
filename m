From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Nov 2016 19:54:26 +0100
Subject: [PATCH 2/2] arm64: dts: sunxi: enable EHCI1, OHCI1 and USB PHY
 nodes in Pine64
In-Reply-To: <20161105143830.10099-2-icenowy@aosc.xyz>
References: <20161105143830.10099-1-icenowy@aosc.xyz>
 <20161105143830.10099-2-icenowy@aosc.xyz>
Message-ID: <20161106185426.gcucyzjcw4zqwizz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 05, 2016 at 10:38:30PM +0800, Icenowy Zheng wrote:
> Pine64 have two USB Type-A ports, which are wired to the two ports of
> A64 USB PHY, and the lower port is the EHCI/OHCI1 port.
> 
> Enable the necessary nodes to enable the lower USB port to work.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 4709590..d836995 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -72,3 +72,15 @@
>  &i2c1_pins {
>  	bias-pull-up;
>  };
> +
> +&usbphy {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};

Please order the nodes by alphebetical order.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161106/7ed96284/attachment.sig>
