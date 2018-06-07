From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 7 Jun 2018 09:35:42 -0700
Subject: [PATCH v2 1/1] ARM: dts: cygnus: enable iproc-hwrng
In-Reply-To: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
References: <1528309291-25579-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <c0b4d69d-2826-320e-974e-c7cdbf341747@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 11:21 AM, Scott Branden wrote:
> From: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> 
> Enable the HW rng driver "iproc-rng200" for all cygnus platforms.
> 
> Signed-off-by: Mohamed Ismail Abdul Packir Mohamed <mohamed-ismail.abdul@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Clement, do you want to test this and reported back?

> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 9fe4f5a..b0e38fa 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -417,6 +417,11 @@
>  			status = "disabled";
>  		};
>  
> +		rng: rng at 18032000 {
> +			compatible = "brcm,iproc-rng200";
> +			reg = <0x18032000 0x28>;
> +		};
> +
>  		sdhci0: sdhci at 18041000 {
>  			compatible = "brcm,sdhci-iproc-cygnus";
>  			reg = <0x18041000 0x100>;
> 


-- 
Florian
