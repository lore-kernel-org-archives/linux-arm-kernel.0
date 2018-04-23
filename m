From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 23 Apr 2018 10:31:27 +0200
Subject: [PATCH] arm64: dts: marvell: armada-37xx: reserve memory for ATF
In-Reply-To: <20180421161859.22d1ed18@windsurf>
References: <20180421140342.25082-1-miquel.raynal@bootlin.com>
 <20180421161859.22d1ed18@windsurf>
Message-ID: <20180423103127.5b9ac041@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, 21 Apr 2018 16:18:59 +0200, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Sat, 21 Apr 2018 16:03:42 +0200, Miquel Raynal wrote:
> > From: Victor Gu <xigu@marvell.com>
> > 
> > The PSCI area should be reserved in Linux for PSCI operations such as
> > suspend/resume.
> > 
> > Reserve 2MiB of memory which matches the area used by ATF (BL1, BL2,
> > BL3x, see [1] in ATF source code). This covers all PSCI code and data
> > area and is 2MiB aligned, which is required by Linux for huge pages
> > handling.
> > 
> > [1] plat/marvell/a3700/common/include/platform_def.h
> > 
> > Signed-off-by: Victor Gu <xigu@marvell.com>
> > [miquel.raynal at bootlin.com: reword of commit message]
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Shouldn't this be done automatically by the bootloader, before passing
> the DTB to the kernel ?

I am working with a 2017.09 mainline U-Boot.

I did not know the bootloader was supposedly in charge of that. But
what if it fails doing it? Fixing the bootloader is one thing, I assume
very few people would update it. Is it worth keeping this in Linux DT?

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
