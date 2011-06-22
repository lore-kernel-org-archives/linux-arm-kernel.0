From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Wed, 22 Jun 2011 09:43:54 +0530
Subject: [PATCH] davinci: da850 EVM: read mac address from SPI flash
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625BDC@dbde02.ent.ti.com>
References: <1307538155-27197-1-git-send-email-sudhakar.raj@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D625BDC@dbde02.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D626311@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2011 at 23:16:56, Nori, Sekhar wrote:
> Hi Sudhakar,
> 
> On Wed, Jun 08, 2011 at 18:32:35, Rajashekhara, Sudhakar wrote:
> > DA850/OMAP-L138 EMAC driver uses random mac address instead of a fixed 
> > one because the mac address is not stuffed into EMAC platform data.
> > 
> > This patch provides a function which reads the mac address stored in 
> > SPI flash (registered as MTD device) and populates the EMAC platform 
> > data. The function which reads the mac address is registered as a 
> > callback which gets called upon addition of MTD device.
> > 
> > NOTE: In case the MAC address stored in SPI flash is erased, follow 
> > the instructions at [1] to restore it.
> > 
> > [1] 
> > http://processors.wiki.ti.com/index.php/GSG:_OMAP-L138_DVEVM_Additiona
> > l_Procedures#Restoring_MAC_address_on_SPI_Flash
> > 
> > Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> > ---

[...]

> > +
> > +	if (mtd_has_partitions())
> > +		register_mtd_user(&da850evm_spi_notifier);
> 
> The v3.0 merge removes mtd_has_partitions() so this fails to build. Can you please fix and re-submit?
> 

I'll rework on this patch and submit it again.

Thanks,
Sudhakar
