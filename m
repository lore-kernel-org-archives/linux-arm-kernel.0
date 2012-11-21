From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Nov 2012 17:03:43 -0800
Subject: [PATCH 4/7] crypto: omap-aes: Remove cpu_is/omap_type check
 from driver
In-Reply-To: <1353351832-6685-5-git-send-email-mgreer@animalcreek.com>
References: <1353351832-6685-1-git-send-email-mgreer@animalcreek.com>
 <1353351832-6685-5-git-send-email-mgreer@animalcreek.com>
Message-ID: <20121121010343.GS18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark A. Greer <mgreer@animalcreek.com> [121119 11:06]:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The omap-aes driver should not check the CPU class or the
> type of OMAP device its on.  The platform code should do
> that instead.

Similar patch for this one too should be queued already.

Regards,

Tony
 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  drivers/crypto/omap-aes.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
> index 093a8af..628c3cc 100644
> --- a/drivers/crypto/omap-aes.c
> +++ b/drivers/crypto/omap-aes.c
> @@ -941,11 +941,6 @@ static int __init omap_aes_mod_init(void)
>  {
>  	pr_info("loading %s driver\n", "omap-aes");
>  
> -	if (!cpu_class_is_omap2() || omap_type() != OMAP2_DEVICE_TYPE_SEC) {
> -		pr_err("Unsupported cpu\n");
> -		return -ENODEV;
> -	}
> -
>  	return  platform_driver_register(&omap_aes_driver);
>  }
>  
> -- 
> 1.7.12
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
