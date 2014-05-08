From: tj@kernel.org (Tejun Heo)
Date: Thu, 8 May 2014 11:00:42 -0400
Subject: [PATCH] ata: pata_at91 only works on sam9
In-Reply-To: <1399560990-1402858-10-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-10-git-send-email-arnd@arndb.de>
Message-ID: <20140508150042.GD5229@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:56:21PM +0200, Arnd Bergmann wrote:
> The smc driver used by pata_at91 is at91sam9 specific, so building
> this driver on another at91 platform results in this error:
> 
> ERROR: "sam9_smc_configure" [drivers/ata/pata_at91.ko] undefined!
> ERROR: "sam9_smc_write_mode" [drivers/ata/pata_at91.ko] undefined!
> ERROR: "sam9_smc_read_mode" [drivers/ata/pata_at91.ko] undefined!
> 
> This patch changes the Kconfig dependency to ensure it always works.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide at vger.kernel.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
