From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 28 Jan 2014 14:33:09 +0100 (CET)
Subject: [Q] block / zynq: DMA bouncing
In-Reply-To: <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
 <20140127170230.GQ15937@n2100.arm.linux.org.uk> <52E69B4E.5010604@monstr.eu>
 <20140127175231.GU15937@n2100.arm.linux.org.uk> <52E69E1E.3020202@monstr.eu>
 <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
Message-ID: <Pine.LNX.4.64.1401281430150.2714@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jan 2014, Guennadi Liakhovetski wrote:

> Hi Michal,
> 
> (trimmed CC a bit)
> 
> On Mon, 27 Jan 2014, Michal Simek wrote:
> 
> > On 01/27/2014 06:52 PM, Russell King - ARM Linux wrote:
> > > On Mon, Jan 27, 2014 at 06:45:50PM +0100, Michal Simek wrote:
> > >> Why 0x4000? IRC Linux for ARM is using space for any purpose.
> > >> Russell knows this much better than I.
> > > 
> > > Probably because as the kernel is loaded at 0x8000, it will place the
> > > swapper page table at 0x4000, thus covering from 0x4000 upwards.
> > 
> > Ah yeah swapper.
> > 
> > > 
> > > Thus, the majority of your un-DMA-able memory will be kernel text or
> > > swapper page tables.
> > 
> > Yes, exactly.
> > 0x0 - 0x4000 - reserving not to be used by DMA
> > 0x4000 - 0x8000 swapper page table
> > 0x8000 - 0x80000 kernel text + up
> 
> Maybe you could submit something like the attached patch upstream. I'm not 
> sure shom you'd like to put as its original author. I put John Linn there 
> as he originally authored commit 5b9f3f2ac8a3e4edae9de7b855f25f757884d84c 

Sorry, I actually meant commit 83e198c01c381a1d90ba07e241a517d1dabf7c84

Guennadi

> from Xilinx tree with the same description, as the attached patch. 
> Unfortunately, that commit didn't have an Sob.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
