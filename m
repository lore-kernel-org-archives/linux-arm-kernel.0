From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Nov 2015 15:03:00 -0500
Subject: [PATCH RESEND v2] sata/mvebu: use #ifdef around suspend/resume
 code
In-Reply-To: <8025767.rG7ykO9yUZ@wuerfel>
References: <8025767.rG7ykO9yUZ@wuerfel>
Message-ID: <20151120200300.GA31848@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 03:16:30PM +0100, Arnd Bergmann wrote:
> The newly added suspend/resume implementation for ahci_mvebu causes
> a link error when CONFIG_PM_SLEEP is disabled:
> 
> ERROR: "ahci_platform_suspend_host" [drivers/ata/ahci_mvebu.ko] undefined!
> ERROR: "ahci_platform_resume_host" [drivers/ata/ahci_mvebu.ko] undefined!
> 
> This adds the same #ifdef here that exists in the ahci_platform driver
> which defines the above functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d6ecf1581488 ("ata: ahci_mvebu: add suspend/resume support")
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.4-fixes.

Thanks.

-- 
tejun
