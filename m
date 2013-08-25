From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Aug 2013 19:08:01 +0100
Subject: [PATCH v5 4/5] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1377086938-29145-5-git-send-email-zonque@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <1377086938-29145-5-git-send-email-zonque@gmail.com>
Message-ID: <20130825180801.GY6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 02:08:57PM +0200, Daniel Mack wrote:
> @@ -750,6 +822,7 @@ static enum dma_status mmp_pdma_tx_status(struct dma_chan *dchan,
>  
>  	spin_lock_irqsave(&chan->desc_lock, flags);
>  	ret = dma_cookie_status(dchan, cookie, txstate);
> +	txstate->residue = mmp_pdma_residue(chan, cookie);

Please consider using dma_set_residue() here - it is legal to call the
tx status function with a NULL txstate.
