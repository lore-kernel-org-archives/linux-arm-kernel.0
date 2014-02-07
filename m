From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Feb 2014 11:39:03 +0100
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <52F4B682.2000201@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <5240492D.6060204@ti.com> <52F4B682.2000201@ti.com>
Message-ID: <463926864.ALblgUKdgH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 February 2014 12:33:38 Roger Quadros wrote:
> 
> This means we need to make CONFIG_SATA_AHCI_PLATFORM depend on CONFIG_GENERIC_PHY or
> select it.
> 
> OR
> 
> Generic PHY layer must be fixed so that the API's are always built in.
> 
> What is the better option? I believe making the PHY API's always built in is the better option.
> 

CONFIG_SATA_AHCI_PLATFORM should do

	"depends on CONFIG_GENERIC_PHY || !CONFIG_GENERIC_PHY"

which is the Kconfig way of saying that if CONFIG_GENERIC_PHY is a module,
CONFIG_SATA_AHCI_PLATFORM needs to be a module as well.

	Arnd
