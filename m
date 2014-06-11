From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 11 Jun 2014 05:17:27 -0700
Subject: [PATCH 2/4] [SCSI] pas16: don't call free_dma()
In-Reply-To: <1402003789-1990031-3-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
 <1402003789-1990031-3-git-send-email-arnd@arndb.de>
Message-ID: <20140611121727.GC8389@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 11:29:47PM +0200, Arnd Bergmann wrote:
> The pas16 scsi driver does not use DMA, and the call to free_dma()
> in its exit function seems to have been copied incorrectly from
> another driver but never caused trouble.
> 
> One case where it gets in the way is randconfig builds on ARM,
> which depending on the configuration does not provide a free_dma()
> function, causing this build error:

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
