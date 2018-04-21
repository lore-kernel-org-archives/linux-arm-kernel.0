From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Sat, 21 Apr 2018 16:18:59 +0200
Subject: [PATCH] arm64: dts: marvell: armada-37xx: reserve memory for ATF
In-Reply-To: <20180421140342.25082-1-miquel.raynal@bootlin.com>
References: <20180421140342.25082-1-miquel.raynal@bootlin.com>
Message-ID: <20180421161859.22d1ed18@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, 21 Apr 2018 16:03:42 +0200, Miquel Raynal wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> The PSCI area should be reserved in Linux for PSCI operations such as
> suspend/resume.
> 
> Reserve 2MiB of memory which matches the area used by ATF (BL1, BL2,
> BL3x, see [1] in ATF source code). This covers all PSCI code and data
> area and is 2MiB aligned, which is required by Linux for huge pages
> handling.
> 
> [1] plat/marvell/a3700/common/include/platform_def.h
> 
> Signed-off-by: Victor Gu <xigu@marvell.com>
> [miquel.raynal at bootlin.com: reword of commit message]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Shouldn't this be done automatically by the bootloader, before passing
the DTB to the kernel ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
