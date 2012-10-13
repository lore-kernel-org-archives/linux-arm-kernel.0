From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 13 Oct 2012 18:00:30 +1300
Subject: [PATCH for 3.7] dtb: fix interrupt assignment for ehci/uhci on
 wm8505
In-Reply-To: <1350101882-6195-1-git-send-email-linux@prisktech.co.nz>
References: <1350101882-6195-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350104430.6448.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-10-13 at 17:18 +1300, Tony Prisk wrote:
> EHCI and UHCI devices in wm8505.dtsi should use IRQ 0 & 1
> respectively - not 43 as used on newer models.

Oops - should have been IRQ 1 & 0 - fixed locally.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  arch/arm/boot/dts/wm8505.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
> index b459691..330f833 100644
> --- a/arch/arm/boot/dts/wm8505.dtsi
> +++ b/arch/arm/boot/dts/wm8505.dtsi
> @@ -71,13 +71,13 @@
>  		ehci at d8007100 {
>  			compatible = "via,vt8500-ehci";
>  			reg = <0xd8007100 0x200>;
> -			interrupts = <43>;
> +			interrupts = <1>;
>  		};
>  
>  		uhci at d8007300 {
>  			compatible = "platform-uhci";
>  			reg = <0xd8007300 0x200>;
> -			interrupts = <43>;
> +			interrupts = <0>;
>  		};
>  
>  		fb at d8050800 {

I assume the usb subsystem doesn't fault when IRQ's aren't recieved as
this did give any error messages, it just made the USB extremely slow -
like it was timing-out between requests.

Regards
Tony P
