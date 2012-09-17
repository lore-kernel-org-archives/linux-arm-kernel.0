From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Sep 2012 13:53:38 -0700
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <20120917192005.ab08c24f98010107fa855edf@canb.auug.org.au>
References: <20120917192005.ab08c24f98010107fa855edf@canb.auug.org.au>
Message-ID: <20120917205338.GA11762@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [120917 02:21]:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/staging/tidspbridge/core/wdt.c between commit c37a1747acbf
> ("staging: tidspbridge: Prepare for irqs.h removal") from the  tree and
> commit ec2c0825ca31 ("ARM: OMAP2+: Remove hardcoded IRQs and enable
> SPARSE_IRQ") from the arm-soc tree.
> 
> I fixed it up (I guess - see below) and can carry the fix as necessary
> (no action is required).

Yes thanks again. This is the right fix for now, eventually
the numbers should come from platform data or device tree..

Regards,

Tony
 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc drivers/staging/tidspbridge/core/wdt.c
> index 1ed1474,453ef74..0000000
> --- a/drivers/staging/tidspbridge/core/wdt.c
> +++ b/drivers/staging/tidspbridge/core/wdt.c
> @@@ -25,8 -25,7 +25,8 @@@
>   #include <dspbridge/host_os.h>
>   
>   
>  +#define OMAP34XX_WDT3_BASE 		(0x49000000 + 0x30000)
> - #define INT_34XX_WDT3_IRQ 		36
> + #define INT_34XX_WDT3_IRQ 		(36 + NR_IRQS)
>   
>   static struct dsp_wdt_setting dsp_wdt;
>   
