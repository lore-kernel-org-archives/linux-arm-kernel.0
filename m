From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 14 Sep 2018 10:01:12 -0700
Subject: [PATCH v2 4/4] ARM: dts: bcm283x: Correct mailbox register sizes
In-Reply-To: <1536931375-48769-5-git-send-email-phil@raspberrypi.org>
References: <1536931375-48769-1-git-send-email-phil@raspberrypi.org>
 <1536931375-48769-5-git-send-email-phil@raspberrypi.org>
Message-ID: <f1322c43-061d-ca04-a0e8-cd4fe02ea1ac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2018 06:22 AM, Phil Elwell wrote:
> The size field in a Device Tree "reg" property is encoded in bytes, not
> words.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

This should probably have a:

Fixes: 614fa22119d6 ("ARM: dts: bcm2835: Add VCHIQ node to the Raspberry
Pi boards. (v3)")

as well?

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 215d8cc..29f970f 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -32,7 +32,7 @@
>  
>  		vchiq: mailbox at 7e00b840 {
>  			compatible = "brcm,bcm2835-vchiq";
> -			reg = <0x7e00b840 0xf>;
> +			reg = <0x7e00b840 0x3c>;
>  			interrupts = <0 2>;
>  		};
>  	};
> 


-- 
Florian
