From: brian.starkey@arm.com (Brian Starkey)
Date: Fri, 29 Jan 2016 09:32:59 +0000
Subject: [RESEND PATCH 0/3] Add MEMREMAP_WC to fix dma_init_coherent_memory
In-Reply-To: <cover.1452010802.git.brian.starkey@arm.com>
References: <cover.1452010802.git.brian.starkey@arm.com>
Message-ID: <20160129093258.GA695@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Are there any comments on these? Without them dma-coherent can't be used
on arm64 so it would be good to get them merged if there are no
objections.

I can resend with Michal's ack for patch 2 if needed.

Thanks,
Brian

On Tue, Jan 05, 2016 at 04:41:25PM +0000, Brian Starkey wrote:
>Hi,
>
>This may well have been buried with the holidays. It still applies
>fine on next-20160105, but I notice patch 2 will trivially conflict
>with [2] on some context lines.
>
>As discussed here[1], these patches implement a MEMREMAP_WC flag for
>memremap(), which can be used to obtain writecombine mappings. This
>is then used for setting up dma_coherent_mem regions which use the
>DMA_MEMORY_MAP flag.
>
>Patch 3 makes sure that the appropriate memset function is used
>when zeroing coherent allocations, which fixes an alignment fault on
>arm64.
>
>Best Regards,
>Brian
>
>[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390857.html
>[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/397163.html
>
>Brian Starkey (3):
>  memremap: add MEMREMAP_WC flag
>  drivers: dma-coherent: use MEMREMAP_WC for DMA_MEMORY_MAP
>  drivers: dma-coherent: use memset_io for DMA_MEMORY_IO
>
> drivers/base/dma-coherent.c |   25 ++++++++++++++++++++-----
> include/linux/io.h          |    1 +
> kernel/memremap.c           |   15 +++++++++++++--
> 3 files changed, 34 insertions(+), 7 deletions(-)
>
>-- 
>1.7.9.5
>
