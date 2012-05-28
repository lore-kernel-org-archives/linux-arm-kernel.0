From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 May 2012 11:22:18 +0300
Subject: [PATCH] mmc: omap: Fix a section warning regression
In-Reply-To: <20120528065347.GR17852@atomide.com>
References: <20120528065347.GR17852@atomide.com>
Message-ID: <20120528082217.GI18918@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 27, 2012 at 11:53:47PM -0700, Tony Lindgren wrote:
> Commit b6e0703b (mmc: omap: make it behave well as a module) made some
> __devinit changes but missed one function causing a section warning:
> 
> WARNING: vmlinux.o(.devinit.text+0x8604): Section mismatch in reference
> from the function mmc_omap_probe)
> The function __devinit mmc_omap_probe() references a function
> __init mmc_omap_new_slot()
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> 
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1300,7 +1300,7 @@ static const struct mmc_host_ops mmc_omap_ops = {
>  	.set_ios	= mmc_omap_set_ios,
>  };
>  
> -static int __init mmc_omap_new_slot(struct mmc_omap_host *host, int id)
> +static int __devinit mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>  {
>  	struct mmc_omap_slot *slot = NULL;
>  	struct mmc_host *mmc;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120528/2669f1a8/attachment.sig>
