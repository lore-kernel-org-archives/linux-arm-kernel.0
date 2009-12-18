From: kpa_info@yahoo.fr (Patrick)
Date: Fri, 18 Dec 2009 04:24:57 -0800 (PST)
Subject: [PXA320] dmac_flush_range and burst on SMEMC
In-Reply-To: <f17812d70912180139k7e6a7cbas48f025abc6f82ea5@mail.gmail.com>
Message-ID: <675299.63543.qm@web23307.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Yes PXA320 L2 cache is enabled.

I do a request_mem_region and after a ioremap_cached.
After I use iowrite32 with the address returned by ioremap_cached.

Actually I simply write 8 times with iowrite32 with incremental address. After, 8 write i use dmac_flush_range to flush the cash (and start a burst).

I do not use DMA API. Should I use it ? 

Patrick

--- En date de?: Ven 18.12.09, Eric Miao <eric.y.miao@gmail.com> a ?crit?:

> De: Eric Miao <eric.y.miao@gmail.com>
> Objet: Re: [PXA320] dmac_flush_range and burst on SMEMC
> ?: "Patrick" <kpa_info@yahoo.fr>
> Cc: linux-arm-kernel at lists.infradead.org
> Date: Vendredi 18 D?cembre 2009, 10h39
> On Fri, Dec 18, 2009 at 5:00 PM,
> Patrick <kpa_info@yahoo.fr>
> wrote:
> > Hello all,
> >
> > I am using a PXA320 with a FPGA connected on the VLIO
> memory bus. For faster transfer between the PXA and the FPGA
> I would like to use burst (supported by the SMEMC in VLIO).
> >
> > I was using a 2.6.26 kernel and burst was working very
> fine. I was using ioremap_cached and after a loop of
> iowrite32 and a call to dmac_flush_range to start the burst.
> It was working fine.
> >
> > I have migrated to a 2.6.28 kernel with the same
> driver code. All the data writed by the loop of iowrite32 is
> lost and only the last burst is writed using PIO and no
> burst. It's like if dmac_flush_range is not working and
> flush no cash at all.
> >
> > Do you have any idea ? Should I use another function
> than dmac_flush_range ?
> 
> Did you enable L2 cache and how your memory region is
> mapped?
> 
> PS: using dmac_* is not recommended, use dma API instead,
> or
> at least dma_cache_maint().
> 


      
