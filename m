From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 20 Oct 2015 11:15:52 +0200
Subject: [PATCH 2/3] mtd: nand: add NAND_NEED_SCRAMBLING flag to the
 H27UCG8T2ATR-BC definition
In-Reply-To: <CAFLxGvx_3ZWMqimh36t1uCSAqbHnD5ZU=vQBMsDHzs6qPxUExQ@mail.gmail.com>
References: <1444929443-25537-1-git-send-email-boris.brezillon@free-electrons.com>
 <1444929443-25537-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAFLxGvx_3ZWMqimh36t1uCSAqbHnD5ZU=vQBMsDHzs6qPxUExQ@mail.gmail.com>
Message-ID: <20151020111552.33d4c23f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Oct 2015 09:20:10 +0200
Richard Weinberger <richard.weinberger@gmail.com> wrote:

> On Thu, Oct 15, 2015 at 7:17 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > The H27UCG8T2ATR-BC requires an external data scrambler. Reflect this
> > constraint in the nand_flash_ids definition.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/nand_ids.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
> > index a8804a3..ccc05f5 100644
> > --- a/drivers/mtd/nand/nand_ids.c
> > +++ b/drivers/mtd/nand/nand_ids.c
> > @@ -50,8 +50,8 @@ struct nand_flash_dev nand_flash_ids[] = {
> >                   SZ_16K, SZ_8K, SZ_4M, 0, 6, 1280, NAND_ECC_INFO(40, SZ_1K) },
> >         {"H27UCG8T2ATR-BC 64G 3.3V 8-bit",
> >                 { .id = {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
> > -                 SZ_8K, SZ_8K, SZ_2M, 0, 6, 640, NAND_ECC_INFO(40, SZ_1K),
> > -                 4 },
> > +                 SZ_8K, SZ_8K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
> > +                 NAND_ECC_INFO(40, SZ_1K), 4 },
> 
> Would it make sense to print a warning if a NAND which needs scrambling
> is used on a NFC which does not support this feature?
> 

Maybe, but if we want to make this warning generic this implies adding
a new NAND_CONTROLLER_SUPPORTS_SCRAMBLING flag.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
