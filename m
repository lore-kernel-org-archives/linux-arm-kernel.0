From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 09:41:41 +0200
Subject: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
In-Reply-To: <1359993540-20780-11-git-send-email-rogerq@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-11-git-send-email-rogerq@ti.com>
Message-ID: <20130205074141.GB32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 05:58:57PM +0200, Roger Quadros wrote:
> Adds device nodes for HS USB Host module, TLL module,
> OHCI and EHCI controllers.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 739bb79..3429280 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -529,5 +529,35 @@
>  			ti,hwmods = "timer11";
>  			ti,timer-pwm;
>  		};
> +
> +		usbhstll: usbhstll at 0x4a062000 {
> +			compatible = "ti,usbhs-tll";
> +			reg = <0x4a062000 0x1000>;
> +			interrupts = <0 78 0x4>;
> +			ti,hwmods = "usb_tll_hs";
> +		};
> +
> +		usbhshost: usbhshost at 0x4a064000 {
> +			compatible = "ti,usbhs-host";
> +			reg = <0x4a064000 0x800>;
> +			ti,hwmods = "usb_host_hs";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			usbhsohci: ohci at 0x4a064800 {

usbhsohci is a bit misleading :-)

How about we stick to ohci and ehci for these nodes ? :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/915e0a9c/attachment.sig>
