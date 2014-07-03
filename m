From: tj@kernel.org (Tejun Heo)
Date: Thu, 3 Jul 2014 10:03:35 -0400
Subject: [PATCH v5 1/2] libahci: Implement the function
 ahci_restart_engine to restart the port dma engine.
In-Reply-To: <1404296108-16233-2-git-send-email-stripathi@apm.com>
References: <1404296108-16233-1-git-send-email-stripathi@apm.com>
 <1404296108-16233-2-git-send-email-stripathi@apm.com>
Message-ID: <20140703140335.GD16191@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 02, 2014 at 03:45:07PM +0530, Suman Tripathi wrote:
> +int ahci_restart_engine(struct ata_port *ap)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +
> +	ahci_stop_engine(ap);
> +	ahci_start_fis_rx(ap);
> +	hpriv->start_engine(ap);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ahci_restart_engine);

I don't get this function.  No other ahci needs it and it's not even
contained libahci proper.  It calls back to the calling low level
driver.  Why not just expose ahci_start_fis_rx() and implement the
above in xgene?

Thanks.

-- 
tejun
