From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 10:47:01 +0200
Subject: [PATCH 28/44] sparc: remove arch specific dma_supported
 implementations
In-Reply-To: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-29-hch@lst.de>
 <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
Message-ID: <20170616084701.GE10582@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 12:22:48AM +1000, Julian Calaby wrote:
> I'm guessing there's a few places that have DMA ops but DMA isn't
> actually supported. Why not have a common method for this, maybe
> "dma_not_supported"?

It's not common at all.  Except for sbus all dma API user first
call set_dma_mask which ends up in the dma_supported call.  sbus
is the weird outlier here.
