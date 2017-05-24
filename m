From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 24 May 2017 13:23:01 +0200
Subject: pxa3xx-nand failing to find device on linux-next
In-Reply-To: <2a79405e219b4c37ba00defbe4a0dfe4@svr-chch-ex1.atlnz.lc>
References: <b36366e358904310aee4970b77f57dba@svr-chch-ex1.atlnz.lc>
 <2a79405e219b4c37ba00defbe4a0dfe4@svr-chch-ex1.atlnz.lc>
Message-ID: <20170524132301.12ad33d8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Wed, 24 May 2017 09:36:56 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> On 23/05/17 17:27, Chris Packham wrote:
> > Hi,
> >
> > I'm doing some testing on linux-next and I'm finding that my nand flash
> > has disappeared.
> >
> > pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
> > pxa3xx-nand f10d0000.flash: non-supported command ef
> > pxa3xx-nand f10d0000.flash: non-supported command ee
> > pxa3xx-nand f10d0000.flash: non-supported command ef
> > pxa3xx-nand f10d0000.flash: non-supported command ee
> > On-die ECC forcefully enabled, not supported
> > nand: No NAND device found
> > pxa3xx-nand f10d0000.flash: failed to scan nand at cs 0
> >
> > This was working around 4.11. I'll try to do some more digging tomorrow
> > to narrow down a failure point but I thought I'd send this out now just
> > in case it rings any bells.
> >
> > The board I'm using (DB-88F6820-AMC) is unfortunately out-of tree but it
> > should be pretty close to the armada-388-db. I can make my dts available
> > if it's helpful.  
> 
> Still works on 4.12-rc2. Fails on next-20170524.
> 
> This appears to be due to commit b566d9c055de ("mtd: nand: add support 
> for Micron on-die ECC"). Which based on the description seems intentional.
> 
> Since I have access to a hardware platform that has a micron flash with
> ECC forcefully enabled how can I help to get this implemented.

Can you try with this patch applied [1]?

Thanks,

Boris

[1]http://code.bulix.org/eic5n9-135873
