From: b38343@freescale.com (Robin Gong)
Date: Wed, 10 Sep 2014 23:18:01 +0800
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <20140910114530.GD7960@sirena.org.uk>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <20140910102105.GR2601@sirena.org.uk>
 <20140910112258.GA30794@Robin-OptiPlex-780>
 <20140910114530.GD7960@sirena.org.uk>
Message-ID: <20140910151759.GA31462@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 12:45:30PM +0100, Mark Brown wrote:
> On Wed, Sep 10, 2014 at 07:22:59PM +0800, Robin Gong wrote:
> > On Wed, Sep 10, 2014 at 11:21:05AM +0100, Mark Brown wrote:
> 
> > > This isn't going to work, anything that looks at the usedma flag will
> > > see the result of the last thing that was checked which may or may not
> > > be the transfer that it's handling.  The driver should check to see if
> > > the core mapped the transfer for DMA.
> 
> > Yes, you're right. I should use "transfer->tx_sg->sgl == NULL" or
> > "transfer->rx_sg->sgl == NULL" instead of usedma flag in driver, right?
> 
> Right.
But looks spi core framework can make sure every rx or tx transfer in sequence.
If so, can_dma will never be called until this transfer finished
(spi_pump_messages), and my usedma flag also never be modified until next
transfer start. Please correct me if I am wrong, thanks.
