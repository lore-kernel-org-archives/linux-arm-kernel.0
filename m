From: htejun@gmail.com (Tejun Heo)
Date: Thu, 20 May 2010 10:48:51 +0200
Subject: [PATCH] PXA DMA-capable PATA driver
In-Reply-To: <201005180053.54248.marek.vasut@gmail.com>
References: <1273460525-25662-1-git-send-email-marek.vasut@gmail.com>
	<4BEDC8C1.30703@garzik.org>
	<201005180053.54248.marek.vasut@gmail.com>
Message-ID: <4BF4F773.102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2010 12:53 AM, Marek Vasut wrote:
> 4766 /**
> 4767  *      atapi_check_dma - Check whether ATAPI DMA can be supported
> 4768  *      @qc: Metadata associated with taskfile to check
> 4769  *
> 4770  *      Allow low-level driver to filter ATA PACKET commands, returning
> 4771  *      a status indicating whether or not it is OK to use DMA for the
> 4772  *      supplied PACKET command.
> 4773  *
> 4774  *      LOCKING:
> 4775  *      spin_lock_irqsave(host lock)
> 4776  *
> 4777  *      RETURNS: 0 when ATAPI DMA can be used
> 4778  *               nonzero otherwise
> 4779  */
> 
> this is from libata-core.c FYI and -EOPNOTSUPP is non-zero.

Argh... that method needs to be changed to return bool.

-- 
tejun
