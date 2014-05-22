From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 10:20:48 -0400
Subject: [PATCH] ARM: mvebu: coherency: fix registration of PCI bus
 notifier when !PCI
In-Reply-To: <1400598783-706-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400598783-706-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140522142048.GO8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:13:03PM +0200, Thomas Petazzoni wrote:
> Commit b0063aad5dd8 ("ARM: mvebu: use hardware I/O coherency also for
> PCI devices") added a reference to the pci_bus_type variable, but this
> variable is only available when CONFIG_PCI is enabled. Therefore,
> there is now a build failure in !CONFIG_PCI situations.
> 
> This commit fixes that by enclosing the entire initcall into a
> IS_ENABLED(CONFIG_PCI) condition.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This applies on top of mvebu/soc. No need to push for 3.15-rc, the
> patch being fixed is only for 3.16.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/soc

thx,

Jason.
