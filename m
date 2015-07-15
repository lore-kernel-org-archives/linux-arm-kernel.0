From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jul 2015 11:56:40 +0200
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <3074236.7KNCYXgBBY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 July 2015 17:32:58 Yuan Yao wrote:
> +#ifdef CONFIG_PM
> +enum fsl_edma_pm_state {
> +       RUNNING = 0,
> +       SUSPENDED,
> +};
> +#endif
>  
>  struct fsl_edma_hw_tcd {
> 

The #ifdefs here seem unnecessary, at least most of them, better
just do this all unconditionally.

	Arnd
