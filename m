From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 8 Jun 2016 09:08:46 +0200
Subject: [PATCH] ARM: dts: at91: usb_a9g20: use stdout-path
In-Reply-To: <1465322350-14079-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465322350-14079-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5757C47E.7020305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/06/2016 19:59, Alexandre Belloni a ?crit :
> Use stdout-path to specify the console and remove the console argument from
> the kernel command line.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/usb_a9g20_common.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/usb_a9g20_common.dtsi b/arch/arm/boot/dts/usb_a9g20_common.dtsi
> index 0b3b36182fe5..6156ee878345 100644
> --- a/arch/arm/boot/dts/usb_a9g20_common.dtsi
> +++ b/arch/arm/boot/dts/usb_a9g20_common.dtsi
> @@ -11,7 +11,8 @@
>  
>  / {
>  	chosen {
> -		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
> +		bootargs = "mem=64M root=/dev/mtdblock5 rw rootfstype=ubifs";
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	memory {
> 


-- 
Nicolas Ferre
