From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 21 Aug 2017 19:52:16 +0200
Subject: [PATCH] ARM: S3C24XX: Fix NAND ECC mode for mini2440 board
In-Reply-To: <1502915461-8625-1-git-send-email-snawrocki@kernel.org>
References: <1502915461-8625-1-git-send-email-snawrocki@kernel.org>
Message-ID: <20170821175216.gzrpwzdu6qrpm6rk@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 10:31:01PM +0200, snawrocki at kernel.org wrote:
> From: Sylwester Nawrocki <snawrocki@kernel.org>
> 
> After commit e9f66ae23c "mtd: s3c2410: make ecc mode configurable
> via platform data" booting of the mini2440 board is broken, since
> for this board we have CONFIG_MTD_NAND_S3C2410_HWECC set. The console
> gets flooded with errors reported by the mtd subsystem.
> This patch changes ecc_mode to NAND_ECC_HW which restores proper
> operation of the NAND flash memory.
> 
> Cc: Sergio Prado <sergio.prado@e-labworks.com>
> Fixes: e9f66ae23c "mtd: s3c2410: make ecc mode configurable via platform data"

Thanks, applied for next cycle. Please do not forget about checkpatch -
he would point about wrong format of commit SHA and fixes tag (too short
SHA and missing ()).

Best regards,
Krzysztof
