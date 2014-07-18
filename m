From: tj@kernel.org (Tejun Heo)
Date: Fri, 18 Jul 2014 09:47:30 -0400
Subject: [PATCH v10 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
In-Reply-To: <1405686607-8126-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140718134730.GA13012@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 02:30:02PM +0200, Antoine T?nart wrote:
> @@ -321,6 +321,8 @@ struct ahci_host_priv {
>  	u32			cap;		/* cap to use */
>  	u32			cap2;		/* cap2 to use */
>  	u32			port_map;	/* port map to use */
> +	u32			force_port_map;	/* force port map */
> +	u32			mask_port_map;	/* mask out particular bits */

So, ->flags and ->force/mask_port_map are the only input ones, right?
Can we collect them to one spot and label them as such?

Thanks.

-- 
tejun
