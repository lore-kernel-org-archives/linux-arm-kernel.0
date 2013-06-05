From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Jun 2013 13:17:44 +0200
Subject: [PATCHv4] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <1370425843-6802-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1370425843-6802-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201306051317.44220.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013, Alexandre Belloni wrote:
> Fixes:
> arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
> :(.text+0x1174): undefined reference to `mdiobus_write'
> :(.text+0x1188): undefined reference to `mdiobus_write'
> :(.text+0x119c): undefined reference to `mdiobus_write'
> :(.text+0x11b0): undefined reference to `mdiobus_write'
> arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
> :(.init.text+0x1e34): undefined reference to `phy_register_fixup_for_uid'
> 
> when CONFIG_PHYLIB is not selected.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
