From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Jun 2016 07:49:39 +0200
Subject: [PATCH 5/7] mtd: nand: Add Hynix H27UBG8T2BTR-BC to nand_ids table
In-Reply-To: <20160606223138.3c2032ee@bbrezillon>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-6-git-send-email-mamlinav@gmail.com>
 <20160606205549.1ecd6fdb@bbrezillon>
 <20160606225903.264abc01647eb1528cc226bd@gmail.com>
 <20160606223138.3c2032ee@bbrezillon>
Message-ID: <20160607074939.09e2b19e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2016 22:31:38 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Mon, 6 Jun 2016 22:59:03 +0300
> Aleksei Mamlin <mamlinav@gmail.com> wrote:
> 
> > On Mon, 6 Jun 2016 20:55:49 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >   
> > > On Mon,  6 Jun 2016 13:24:22 +0300
> > > Aleksei Mamlin <mamlinav@gmail.com> wrote:
> > >     
> > > > Add the full description of the Hynix H27UBG8T2BTR-BC NAND chip in the
> > > > nand_ids table so that we can later use the NAND ECC infos and ONFI timings
> > > > mode in controller drivers.    
> > > 
> > > Still hoping to get this series [1] merged in 4.8, but if that's
> > > not the case, I'll apply your patch.
> > > 
> > > BTW, that would be great if you could test it on your platforms.
> > >     
> > 
> > It seems that Hynix-specific initialization code can't handle H27UBG8T2BTR-BC
> > chip:
> > 
> > [    0.886153] nand: Could not find valid ONFI parameter page; aborting
> > [    0.892665] nand: device found, Manufacturer ID: 0xad, Chip ID: 0xd7
> > [    0.899025] nand: Hynix 1c03000.nand
> > [    0.902596] nand: bus width 8 instead 16 bit
> > [    0.906858] nand: No NAND device found
> > [    0.910620] sunxi_nand 1c03000.nand: failed to init nand chips
> > [    0.916528] sunxi_nand: probe of 1c03000.nand failed with error -22  
> 
> Can you try this patch? It should fix the problem [1].

Brian, I have a question regarding the extended NAND ids (not full-ids)
defined in the nand_ids table. Are they really valid for all vendors?

If that's the case, why are we extracting the bus width from the id[3]
since we already have this information in the options field?

> 
> [1]http://code.bulix.org/6hjww1-100494
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
