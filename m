From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 May 2014 11:17:03 -0500
Subject: [PATCH 4/4] ARM: dts: am335x-igep0033: use phandles for USB and
 DMA refs
In-Reply-To: <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
 <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <20140506161703.GM25849@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 10:58:32AM -0300, Guido Mart?nez wrote:
> Use phandles instead of unit adresses to reference usb and dma nodes.
> This makes the DT more robust and readable.
> 
> Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/boot/dts/am335x-igep0033.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
> index 9f22c18..81cf68b 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -201,28 +201,28 @@
>  &usb {
>  	status = "okay";
>  
> -	control at 44e10620 {
> +	&usb_ctrl_mod {
>  		status = "okay";
>  	};
>  
> -	usb-phy at 47401300 {
> +	&usb0_phy {
>  		status = "okay";
>  	};
>  
> -	usb-phy at 47401b00 {
> +	&usb1_phy {
>  		status = "okay";
>  	};
>  
> -	usb at 47401000 {
> +	&usb0 {
>  		status = "okay";
>  	};
>  
> -	usb at 47401800 {
> +	&usb1 {
>  		status = "okay";
>  		dr_mode = "host";
>  	};
>  
> -	dma-controller at 47402000  {
> +	&cppi41dma  {
>  		status = "okay";
>  	};
>  };
> -- 
> 1.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/b28fe452/attachment.sig>
