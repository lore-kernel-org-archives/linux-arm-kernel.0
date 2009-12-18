From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Dec 2009 17:39:18 +0800
Subject: [PXA320] dmac_flush_range and burst on SMEMC
In-Reply-To: <354684.99618.qm@web23301.mail.ird.yahoo.com>
References: <354684.99618.qm@web23301.mail.ird.yahoo.com>
Message-ID: <f17812d70912180139k7e6a7cbas48f025abc6f82ea5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2009 at 5:00 PM, Patrick <kpa_info@yahoo.fr> wrote:
> Hello all,
>
> I am using a PXA320 with a FPGA connected on the VLIO memory bus. For faster transfer between the PXA and the FPGA I would like to use burst (supported by the SMEMC in VLIO).
>
> I was using a 2.6.26 kernel and burst was working very fine. I was using ioremap_cached and after a loop of iowrite32 and a call to dmac_flush_range to start the burst. It was working fine.
>
> I have migrated to a 2.6.28 kernel with the same driver code. All the data writed by the loop of iowrite32 is lost and only the last burst is writed using PIO and no burst. It's like if dmac_flush_range is not working and flush no cash at all.
>
> Do you have any idea ? Should I use another function than dmac_flush_range ?

Did you enable L2 cache and how your memory region is mapped?

PS: using dmac_* is not recommended, use dma API instead, or
at least dma_cache_maint().
