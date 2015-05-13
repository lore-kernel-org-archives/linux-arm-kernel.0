From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 08:22:45 +0300
Subject: [PATCH v2 0/4] mtd: mxc_nand: fix 8 bit ECC and large oob
In-Reply-To: <20150508051538.GW6325@pengutronix.de>
References: <cover.1430636819.git.baruch@tkos.co.il>
 <20150508051538.GW6325@pengutronix.de>
Message-ID: <20150513052245.GJ2558@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, May 08, 2015 at 07:15:38AM +0200, Sascha Hauer wrote:
> On Sun, May 03, 2015 at 10:18:50AM +0300, Baruch Siach wrote:
> > This patch series fixes mxc_nand bugs that I encountered while trying to use 8
> > bit ECC mode on i.MX25 with the Micron MT29F8G08ABABA flash chip.
> > 
> > Many thanks to Uwe Kleine-K?nig for guiding me through the process of
> > debugging and fixing, and for contributing a clean-up patch to this series.
> > 
> > This series applies and tested on v4.1-rc1.
> > 
> > This is version 2 of the patch series, addressing the comments and suggestion
> > of Uwe Kleine-K?nig on the first series
> > (http://thread.gmane.org/gmane.linux.ports.arm.kernel/408635). See each patch
> > for detailed per-patch changelog.
> > 
> > Baruch Siach (3):
> >   mtd: mxc_nand: limit the size of used oob
> >   mtd: mxc_nand: fix truncate of unaligned oob copying
> >   mtd: mxc_nand: generate nand_ecclayout for 8 bit ECC
> > 
> > Uwe Kleine-K?nig (1):
> >   mtd: nand: mxc_nand: cleanup copy_spare function
> 
> I looked at this version and have only found some minor coding style
> violations (spaces missing on both sides of operators).

Documentation/CodingStyle mentions it but checkpatch.pl doesn't warn. I find 
it more readable to omit spaces around the * operator when mixing with +. 

	layout->eccpos[i*18 + j] = i*26 + j + 7;

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for reviewing,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
