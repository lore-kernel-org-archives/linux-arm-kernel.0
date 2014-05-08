From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 08 May 2014 16:06:32 +0100
Subject: [PATCH] pci: rcar host needs OF
In-Reply-To: <1399560990-1402858-14-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-14-git-send-email-arnd@arndb.de>
Message-ID: <536B9D78.5000602@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 15:56, Arnd Bergmann wrote:
> The pci-rcar driver is enabled for compile tests, and this has
> now shown that the driver cannot build without CONFIG_OF,
> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> interrupt mapping when possible":
>
> drivers/built-in.o: In function `rcar_pci_map_irq':
> :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-sh at vger.kernel.org
> ---
>   drivers/pci/host/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index fbbef0b..4675f47 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -27,7 +27,7 @@ config PCI_TEGRA
>
>   config PCI_RCAR_GEN2
>   	bool "Renesas R-Car Gen2 Internal PCI controller"
> -	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> +	depends on ARCH_SHMOBILE || (ARM && OF && COMPILE_TEST)
>   	help
>   	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
>   	  There are 3 internal PCI controllers available with a single
>

This driver /should/ be able to be built for just the platform case
so it sounds like f8f2fe7355fb stopped this but no-one has yet to
notice.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
