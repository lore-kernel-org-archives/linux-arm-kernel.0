From: tj@kernel.org (Tejun Heo)
Date: Tue, 17 Jun 2014 12:21:56 -0400
Subject: [PATCH v2 1/2] libahci: Implement the function
 ahci_restart_engine to restart the port dma engine.
In-Reply-To: <1402911336-31788-2-git-send-email-stripathi@apm.com>
References: <1402911336-31788-1-git-send-email-stripathi@apm.com>
 <1402911336-31788-2-git-send-email-stripathi@apm.com>
Message-ID: <20140617162156.GI31819@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jun 16, 2014 at 03:05:35PM +0530, Suman Tripathi wrote:
> This patch implements the function ahci_restart_engine function to restart the port dma engine.

Please fit the text under 80 column.

> ---

I can't apply w/o your SOB.

> +int ahci_restart_engine(struct ata_port *ap)
> +{
> +	ahci_stop_engine(ap);
> +	ahci_start_fis_rx(ap);
> +	ahci_start_engine(ap);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ahci_restart_engine);

Why is this exported?  The next patch doesn't seem to use the function
outside libahci.c proper.

Thanks.

-- 
tejun
