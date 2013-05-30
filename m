From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 23:19:33 +0200
Subject: MUSB multiplatform work?
In-Reply-To: <20130530203132.GC6467@atomide.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <CACRpkdZHupVFS+pNADpaJjunPa3fEtyCqLwbL-etHs3gt8EW0Q@mail.gmail.com>
 <20130530203132.GC6467@atomide.com>
Message-ID: <CACRpkdaUegc7B8awUiQTvFRJHPMWv6hEEsE-2AHtZCDXVEMN9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 10:31 PM, Tony Lindgren <tony@atomide.com> wrote:

> There are many devices where the device FIFO is memory mapped to the
> GPMC bus on omaps, like TUSB, OneNAND, smc911x etc. I believe the
> only reason why these have not been converted to the dmaengine is
> the fact that dmaengine cannot configure the DMA hardware to do
> autoincrement and loop over the device FIFO.

OK that seems like something pretty generic that we could just add
to the struct dma_slave_config actually, something like:

u32 src_fifoloop;
u32 dst_fifoloop;

Given in # of words on the src/dst address simply, left as zero
for hitting a constant address over and over again.

We'd need both to make space for device->device transfers.

If this is all that is needed to convert them do DMAengine
I'd surely ACK it (FWIW).

Yours,
Linus Walleij
