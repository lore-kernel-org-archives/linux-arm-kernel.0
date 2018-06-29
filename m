From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 13:44:07 +0200
Subject: [PATCH v2] arm64: dts: marvell: armada-37xx: reserve memory for
 ATF
In-Reply-To: <20180626081701.27176-1-miquel.raynal@bootlin.com>
References: <20180626081701.27176-1-miquel.raynal@bootlin.com>
Message-ID: <20180629134407.112819d2@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 26 Jun 2018 10:17:01 +0200, Miquel Raynal wrote:
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
> Please note that this is a default setup allowing to perform PSCI
> operations with legacy bootloaders. Recent bootloaders should update the
> region size/position accordingly.
> 
> [1] plat/marvell/a3700/common/include/platform_def.h
> 
> Signed-off-by: Victor Gu <xigu@marvell.com>
> [miquel.raynal at bootlin.com: reword of commit message, comment in the DTSI]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
