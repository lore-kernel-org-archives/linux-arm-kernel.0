From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Oct 2014 12:46:39 +0200
Subject: [PATCH] nand: omap2: fix building with CONFIG_MTD_NAND_OMAP_BCH=m
In-Reply-To: <20141001102419.GA2085@arch.hh.imgtec.org>
References: <1811108.CcWEs0vKNL@wuerfel> <1943672.dOtqDNIvT0@wuerfel>
 <20141001102419.GA2085@arch.hh.imgtec.org>
Message-ID: <2061777.ebdfGlRHlL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 07:24:19 Ezequiel Garcia wrote:
> > 
> > config MTD_NAND_OMAP_BCH_BUILD
> >       def_tristate MTD_NAND_OMAP2 && MTD_NAND_OMAP_BCH
> > 
> > which makes it 'm' if MTD_NAND_OMAP_BCH is set to m.
> > 
> 
> Just to clarify, you are talking about this one being the correct one,
> right?
> 
> http://article.gmane.org/gmane.linux.ports.arm.omap/118488
> "[PATCH 3/3] mtd: nand: Force omap_elm to be built as a module if omap2_nand is a module"
> 
> 

Yes. The four lines you have in there

+config MTD_NAND_OMAP_BCH_BUILD
+	tristate
+	depends on MTD_NAND_OMAP2
+	default m if MTD_NAND_OMAP2=m && MTD_NAND_OMAP_BCH
+	default y if MTD_NAND_OMAP2=y && MTD_NAND_OMAP_BCH

should be entirely equivalent to the two lines I wrote above, so my version
is just a readability change, functionally they both are correct as far as
I can tell.

	Arnd
