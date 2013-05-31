From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 May 2013 14:20:04 -0700
Subject: [PATCH] mfd: twl-core: convert to module_init()
In-Reply-To: <1370033794-5357-1-git-send-email-khilman@linaro.org>
References: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Message-ID: <20130531212003.GR6467@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130531 14:02]:
> There's no reason for twl-core to be subsys_inicall anymore.  Anything
> using twl that early needs a rethink, or deferred probe changes.
> 
> Boot tested and RTC wake tested (via TWL RTC) on OMAP platforms:
> 3530/Beagle, 3730/Beagle-xM, 3530/Overo, 3730/Overo-STORM, 4430/Panda,
> 4460/Panda-ES.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Totally agree:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 89ab4d9..7749b9e 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -1309,7 +1309,7 @@ static int __init twl_init(void)
>  {
>  	return i2c_add_driver(&twl_driver);
>  }
> -subsys_initcall(twl_init);
> +module_init(twl_init);
>  
>  static void __exit twl_exit(void)
>  {
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
