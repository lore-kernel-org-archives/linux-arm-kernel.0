From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 30 Nov 2015 12:44:28 -0800
Subject: [PATCH] mtd: cfi: enforce valid geometry configuration
In-Reply-To: <3747078.dk5V5gxuXa@wuerfel>
References: <3747078.dk5V5gxuXa@wuerfel>
Message-ID: <20151130204428.GM64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 02:39:33PM +0100, Arnd Bergmann wrote:
> MTD allows compile-time configuration of the possible CFI geometry
> settings that are allowed by the kernel, but that includes a couple of
> invalid configurations, where no bank width or no interleave setting
> is allowed. These are then caught with a compile-time warning:
> 
> include/linux/mtd/cfi.h:76:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
> include/linux/mtd/map.h:145:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
> 
> This is a bit annoying for randconfig tests, and can be avoided if
> we change the Kconfig logic to always select the simplest configuration
> when no other one is enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pushed to l2-mtd.git. Thanks for fixing this one! I guess an ugly fix is
better than nothing here.
