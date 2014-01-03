From: giometti@enneenne.com (Rodolfo Giometti)
Date: Fri, 3 Jan 2014 12:29:27 +0100
Subject: NAND support for Armada 370
In-Reply-To: <20140102144236.270c4a6a@skate>
References: <20140102124407.GF10251@enneenne.com>
 <20140102144236.270c4a6a@skate>
Message-ID: <20140103112926.GP10251@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 02:42:36PM +0100, Thomas Petazzoni wrote:
> 
> The 3.13-rc kernels do not have NAND support for Armada 370/XP. The
> NAND support will only arrive in 3.14. You can try the linux-next tree,
> but I'm not sure it has absolutely all of the patches that are needed
> (I see at least one potentially missing).
> 
> Alternatively, you can use the backport-3.10 branch at
> https://github.com/MISL-EBU-System-SW/mainline-public/commits/backport-3.10.
> It is based on 3.10, and has a good number of backported patches,
> including NAND support.

I got several patches from here:

   https://github.com/MISL-EBU-System-SW/mainline-public.git

and now I have:

   pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
   NAND device: Manufacturer ID: 0x2c, Chip ID: 0xf1 (Micron MT29F1G08ABADAWP)
   NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
   pxa3xx-nand f10d0000.nand: ECC strength 4 at page size 2048 is not supported
   pxa3xx-nand f10d0000.nand: failed to scan nand at cs 0

So I suppose I should modify function pxa_ecc_init() in file
drivers/mtd/nand/pxa3xx_nand.c in order to support my NAND chip, is
that right? Have you any advice for me about it? :)

Thanks a lot,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
