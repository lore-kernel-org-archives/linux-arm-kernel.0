From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 27 Jul 2011 10:32:01 +0530
Subject: [PATCH v4] davinci: da850 EVM: read mac address from SPI flash
In-Reply-To: <1310466533-24474-1-git-send-email-sudhakar.raj@ti.com>
References: <1310466533-24474-1-git-send-email-sudhakar.raj@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2D6BA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 15:58:53, Rajashekhara, Sudhakar wrote:
> DA850/OMAP-L138 EMAC driver uses random mac address instead of
> a fixed one because the mac address is not stuffed into EMAC
> platform data.
> 
> This patch provides a function which reads the mac address
> stored in SPI flash (registered as MTD device) and populates the
> EMAC platform data. The function which reads the mac address is
> registered as a callback which gets called upon addition of MTD
> device.
> 
> NOTE: In case the MAC address stored in SPI flash is erased, follow
> the instructions at [1] to restore it.
> 
> [1] http://processors.wiki.ti.com/index.php/GSG:_OMAP-L138_DVEVM_Additional_Procedures#Restoring_MAC_address_on_SPI_Flash
> 
> Modifications in v2:
> Guarded registering the mtd_notifier only when MTD is enabled.
> Earlier this was handled using mtd_has_partitions() call, but
> this has been removed in Linux v3.0.
> 
> Modifications in v3:
> a. Guarded da850_evm_m25p80_notify_add() function and
>    da850evm_spi_notifier structure with CONFIG_MTD macros.
> b. Renamed da850_evm_register_mtd_user() function to
>    da850_evm_setup_mac_addr() and removed the struct mtd_notifier
>    argument to this function.
> c. Passed the da850evm_spi_notifier structure to register_mtd_user()
>    function.
> 
> Modifications in v4:
> Moved the da850_evm_setup_mac_addr() function within the first
> CONFIG_MTD ifdef construct.
> 
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Its impossible to get a stable IP address on Da850 EVM without
this patch so will send for v3.1. Will also add a stable tag
while applying.

Thanks,
Sekhar
