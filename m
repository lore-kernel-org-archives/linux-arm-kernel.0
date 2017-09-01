From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 1 Sep 2017 13:30:26 +0100
Subject: [PATCH] ARM: Kconfig: fix example for ARM_APPENDED_DTB
In-Reply-To: <1504268120-17237-1-git-send-email-vladimir.murzin@arm.com>
References: <1504268120-17237-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170901123026.GD1933@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Fri, Sep 01, 2017 at 01:15:20PM +0100, Vladimir Murzin wrote:
> Help message for config ARM_APPENDED_DTB suggests following example to
> append dtb to zImage:
> 
> cat zImage <filename>.dtb > zImage_w_dtb
> 
> and that makes unaware user wondering why Linux doesn't boot.
> 
> So fix example with ">>". Unfortunately, the same example is present in
> message to commit e2a6a3aafa98 ("ARM: zImage: Allow the appending of a
> device tree binary").

I think that as-is, the example is correct, as `zImage_w_dtb` is a
different file to `zImage`.

... but perhaps the wording could be updated to make that clearer.

Thanks,
Mark.

> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 61a0cb1..756f50f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1893,7 +1893,7 @@ config ARM_APPENDED_DTB
>  	help
>  	  With this option, the boot code will look for a device tree binary
>  	  (DTB) appended to zImage
> -	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> +	  (e.g. cat zImage <filename>.dtb >> zImage_w_dtb).
>  
>  	  This is meant as a backward compatibility convenience for those
>  	  systems with a bootloader that can't be upgraded to accommodate
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
