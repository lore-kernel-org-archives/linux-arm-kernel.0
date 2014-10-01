From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 1 Oct 2014 07:25:45 -0300
Subject: [PATCH] nand: omap2: fix building with CONFIG_MTD_NAND_OMAP_BCH=m
In-Reply-To: <2306426.hFH1ds3Hiv@wuerfel>
References: <1811108.CcWEs0vKNL@wuerfel> <1943672.dOtqDNIvT0@wuerfel>
 <542BD277.6070509@ti.com> <2306426.hFH1ds3Hiv@wuerfel>
Message-ID: <20141001102545.GB2085@arch.hh.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01 Oct 12:13 PM, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 13:07:51 Roger Quadros wrote:
> > On 10/01/2014 12:56 PM, Arnd Bergmann wrote:
> > > On Wednesday 01 October 2014 12:32:09 Roger Quadros wrote:
> > >>
> > >> With this patch NAND probe on DRA7xx fails like so
> > >>
> > >> [    2.077313] omap-gpmc 50000000.gpmc: GPMC revision 6.0
> > >> [    2.083842] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xca
> > >> [    2.090524] nand: Micron MT29F2G16ABAEAWP
> > >> [    2.094728] nand: 256MiB, SLC, page size: 2048, OOB size: 64
> > >> [    2.100745] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
> > >> [    2.109764] omap2-nand: probe of omap2-nand.0 failed with error -38
> > >>
> > >> OMAP NAND driver is the only user of the ELM module and we want it
> > >> to be usable in all possible configurations when enabled.
> > > 
> > > I don't understand. Is the BCH driver optional or not?
> > > 
> > It is optional. If it is disabled we error out on platforms that have
> > the ELM IP. But if it is enabled, we don't want to fail probe on such platforms.
> 
> Wouldn't it be better to treat the absence of the ELM driver the
> same way as the absence of the ELM hardware?
> 

Indeed, it would be better to provide a fallback to the non-ELM behavior
if *anything* prevents initializing it.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
