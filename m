From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 11 Jun 2014 05:17:55 -0700
Subject: [PATCH 4/4] [SCSI] NCR53c406a: don't call free_dma() by default
In-Reply-To: <1402003789-1990031-5-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
 <1402003789-1990031-5-git-send-email-arnd@arndb.de>
Message-ID: <20140611121755.GE8389@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 11:29:49PM +0200, Arnd Bergmann wrote:
> The NCR53c406a scsi driver normally does not use DMA, unless
> the USE_PIO macro is disabled by modifying the source code.
> 
> The call to free_dma() for some reason uses #ifdef USE_DMA,
> which does not do the right thing, since USE_DMA is defined
> as a boolean that is either 0 or 1, but always present.
> 
> One case where it gets in the way is randconfig builds on ARM,
> which depending on the configuration does not provide a free_dma()
> function, causing this build error:

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
