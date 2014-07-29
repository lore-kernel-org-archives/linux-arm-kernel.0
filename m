From: tj@kernel.org (Tejun Heo)
Date: Tue, 29 Jul 2014 10:40:42 -0400
Subject: [PATCH v11 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
In-Reply-To: <1406193450-17283-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140729144042.GD4791@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple nit picks.

On Thu, Jul 24, 2014 at 11:17:25AM +0200, Antoine T?nart wrote:
> @@ -321,6 +321,8 @@ struct ahci_host_priv {
>  	u32			cap;		/* cap to use */
>  	u32			cap2;		/* cap2 to use */
>  	u32			port_map;	/* port map to use */
> +	u32			force_port_map;	/* force port map */
> +	u32			mask_port_map;	/* mask out particular bits */

Let's collect the inputs, including flags, at the top and mark them clearly.

>  int ahci_platform_init_host(struct platform_device *pdev,
>  			    struct ahci_host_priv *hpriv,
>  			    const struct ata_port_info *pi_template,
> -			    unsigned long host_flags,
> -			    unsigned int force_port_map,
> -			    unsigned int mask_port_map)
> +			    unsigned long host_flags)

This doesn't make much sense to me.  Near the head of the function, it
does

	hpriv->flags |= host_flags;

Wouldn't it make more sense to just let the caller set hpriv->flags?

Thanks.

-- 
tejun
