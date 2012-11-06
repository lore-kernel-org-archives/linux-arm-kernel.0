From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Nov 2012 16:29:50 +0200
Subject: [PATCH v2] ARM: dts: AM33XX: Add usbss node
In-Reply-To: <1352212178-8472-1-git-send-email-afzal@ti.com>
References: <1352212178-8472-1-git-send-email-afzal@ti.com>
Message-ID: <20121106142950.GA3056@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 06, 2012 at 07:59:38PM +0530, Afzal Mohammed wrote:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Device tree node for usbss on AM33XX. There are two musb
> controllers on am33xx platform so have port0-mode and
> port1-mode data.
> 
> [afzal at ti.com: reg & interrupt property addition]
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
> Signed-off-by: Ravi Babu <ravibabu@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

to my eyes, this looks ok.

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> 
> v2: node named as "usb"
> 
> Depends on "usb: musb: dsps: dt binding - add resources, example"
> (https://patchwork.kernel.org/patch/1704691/)
> 
>  arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 5dfd682..20a3f29 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -321,5 +321,22 @@
>  			ti,hwmods = "spi1";
>  			status = "disabled";
>  		};
> +
> +		usb at 47400000 {
> +			compatible = "ti,musb-am33xx";
> +			reg = <0x47400000 0x1000	/* usbss */
> +			       0x47401000 0x800		/* musb instance 0 */
> +			       0x47401800 0x800>;	/* musb instance 1 */
> +			interrupts = <17		/* usbss */
> +				      18		/* musb instance 0 */
> +				      19>;		/* musb instance 1 */
> +			multipoint = <1>;
> +			num-eps = <16>;
> +			ram-bits = <12>;
> +			port0-mode = <3>;
> +			port1-mode = <3>;
> +			power = <250>;
> +			ti,hwmods = "usb_otg_hs";
> +		};
>  	};
>  };
> -- 
> 1.7.12
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121106/34961b09/attachment.sig>
