From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 23:12:40 +0100
Subject: [PATCH] mtd: cfi: enforce valid geometry configuration
In-Reply-To: <3747078.dk5V5gxuXa@wuerfel>
References: <3747078.dk5V5gxuXa@wuerfel>
Message-ID: <4492128.vrqmf1niG3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 November 2015 14:39:33 Arnd Bergmann wrote:
> MTD allows compile-time configuration of the possible CFI geometry
> settings that are allowed by the kernel, but that includes a couple of
> invalid configurations, where no bank width or no interleave setting
> is allowed. These are then caught with a compile-time warning:
> 
> include/linux/mtd/cfi.h:76:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
> include/linux/mtd/map.h:145:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"
> 

I'm actually still getting the warnings for any file that includes <linux/mtd/map.h>
while CONFIG_MTD is disabled. I have a fix now that I'm testing overnight
and plan to post tomorrow, then we can decide whether it should be part of
the same patch, or we should have two separate patches.

	Arnd
