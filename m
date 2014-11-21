From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:05:56 +0100
Subject: linux-next: manual merge of the driver-core tree with the arm-soc
 tree
In-Reply-To: <20141121164131.0190e0ab@canb.auug.org.au>
References: <20141121164131.0190e0ab@canb.auug.org.au>
Message-ID: <5291580.tnIkyRiF2h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 16:41:31 Stephen Rothwell wrote:
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@@ -358,8 -300,6 +358,7 @@@ static struct platform_driver omap_l3_d
>         .probe          = omap_l3_probe,
>         .driver         = {
>                 .name           = "omap_l3_noc",
> -               .owner          = THIS_MODULE,
>  +              .pm             = L3_DEV_PM_OPS,
>                 .of_match_table = of_match_ptr(l3_noc_match),
>         },
>   };
> 

Thanks, looks good.

	Arnd
