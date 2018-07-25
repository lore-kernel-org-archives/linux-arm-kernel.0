From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 25 Jul 2018 14:47:17 +0200
Subject: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
In-Reply-To: <20180725115116.1fb38fe3@bbrezillon>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-5-miquel.raynal@bootlin.com>
 <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
 <20180725115116.1fb38fe3@bbrezillon>
Message-ID: <20180725144717.604d3197@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 25 Jul 2018
11:51:16 +0200:

> On Wed, 25 Jul 2018 18:42:44 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > 
> > You need to remove kfree(denali->buf)
> > from denali_remove(), right?  
> 
> Absolutely.
> 
> > 
> > void denali_remove(struct denali_nand_info *denali)
> > {
> >         struct mtd_info *mtd = nand_to_mtd(&denali->nand);
> > 
> >         nand_release(mtd);
> >         kfree(denali->buf);       <---- REMOVE !!
> >         denali_disable_irq(denali);
> > }
> > 
> > 
> > Otherwise, denali_remove() will free denali->buf twice
> > because kfree(denali->buf) is called from denali_detach_chip().  
> 

Absolutely, thanks for reviewing!

I'll apply with this changed.

Miqu?l
