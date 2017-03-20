From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 20:03:21 +0100
Subject: [PATCH v4 5/8] ARM: sunxi: h3/h5: add usb_otg and OHCI/EHCI for
 usbc0 on H3/H5
In-Reply-To: <20170319163118.56301-1-icenowy@aosc.xyz>
References: <20170319163118.56301-1-icenowy@aosc.xyz>
Message-ID: <20170320190321.op76vhg7hrt2gtho@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4601;0c
On Mon, Mar 20, 2017 at 12:31:15AM +0800, Icenowy Zheng wrote:
> Allwinner H3/H5 have a dual-routed USB PHY0 -- routed to either OHCI/EHCI
> or MUSB controller.
> 
> Add device nodes for these controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v4:
> - Add h5 to commit message.
> Changes in v3:
> - Add "h3:" to commit message.
> 
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 2494ea063cd4..213a2befe3af 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -144,6 +144,19 @@
>  			#size-cells = <0>;
>  		};
>  
> +		usb_otg: usb at 01c19000 {
> +			compatible = "allwinner,sun8i-h3-musb";
> +			reg = <0x01c19000 0x0400>;

Please drop the size's leading 0.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/0899c3d3/attachment.sig>
