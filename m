From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 Jul 2016 14:23:37 -0700
Subject: [PATCH] ARM: dts: NSP: Correct RAM amount for BCM958625HR board
In-Reply-To: <1468433929-12232-1-git-send-email-jon.mason@broadcom.com>
References: <1468433929-12232-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <5786B159.7060102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2016 11:18 AM, Jon Mason wrote:
> The BCM958625HR board has 2GB of RAM available.  Increase the amount
> from 512MB to 2GB and add the device type to the memory entry.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm958625hr.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
> index 4239e58..66c658a 100644
> --- a/arch/arm/boot/dts/bcm958625hr.dts
> +++ b/arch/arm/boot/dts/bcm958625hr.dts
> @@ -47,7 +47,8 @@
>  	};
>  
>  	memory {
> -		reg = <0x60000000 0x20000000>;
> +		device_type = "memory";
> +		reg = <0x60000000 0x40000000>;

That's just one 1GB, did you intend to provide 0x8000_0000 instead here?
-- 
Florian
