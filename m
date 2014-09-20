From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Sat, 20 Sep 2014 13:03:15 +0200
Subject: [PATCH v4 0/2] mtd: nand: add sunxi NAND flash controller support
In-Reply-To: <20140920043438.GD8127@brian-ubuntu>
References: <1408382788-32153-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140920043438.GD8127@brian-ubuntu>
Message-ID: <20140920130315.197ab359@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Fri, 19 Sep 2014 21:34:38 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> Hi Boris,
> 
> On Mon, Aug 18, 2014 at 07:26:26PM +0200, Boris BREZILLON wrote:
> > This patch series adds support for the sunxi NAND Flash Controller (NFC)
> > block.
> > 
> > These two patches only add support for the basic NAND stuff:
> >  - NAND controller operations
> >  - SW and HW ECC handling (with both syndrome and normal ECC scheme)
> > 
> > If you want support for advanced features you can find it on my github
> > repo [1]:
> >  - HW randomization support
> >  - per partition ECC/Randomizer to handle bootloader partitions
> > 
> > DMA transfers are not supported yet, but I have reworked the OOB layout
> > when using the HW ECC scheme to match the one used when accessing the NAND
> > with DMA transfers (the available OOB bytes are placed at the end of the
> > OOB area).
> > 
> > This patch series depends on this other one [2] which adds support for ONFI
> > timing mode retrieval on non-ONFI NANDs.
> 
> Were you planning to send v2 of your series [2]? I see you made a
> mistake you were planning on fixing:
> 
>   https://lkml.org/lkml/2014/7/30/423

Yep, I was just waiting for your feedback before fixing it ;-).

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
