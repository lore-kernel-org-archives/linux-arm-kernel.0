From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Nov 2013 14:12:32 -0800
Subject: [PATCH 0/7] AES/DES hwmod data and dmtimer fix
In-Reply-To: <1385415876-12387-1-git-send-email-joelf@ti.com>
References: <1385415876-12387-1-git-send-email-joelf@ti.com>
Message-ID: <20131125221232.GV10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Joel Fernandes <joelf@ti.com> [131125 13:46]:
> Here are patches adding hwmod for AES/DES crypto modules for OMAP4, DRA7 SoCs.
> 
> Also included is a fix that disables POSTED mode when dmtimer is requested.
> 
> Joel Fernandes (7):
>   ARM: OMAP: hwmod: Add SYSC offsets for AES IP
>   ARM: DRA7xx: hwmod: Add hwmod data for DES IP
>   ARM: DRA7xx: hwmod: Add hwmod data for AES IP
>   ARM: OMAP4: hwmod: Add hwmod data for AES IP
>   ARM: OMAP4: hwmod: add hwmod data for DES IP
>   ARM: OMAP: Disable POSTED mode for errata i103 and i767
>   OMAP: AM33xx: hwmod: Correct AES module SYSC type
> 
>  arch/arm/mach-omap2/omap_hwmod.h                   |  11 +++
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   1 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 101 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  78 ++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_common_data.c       |  10 ++
>  arch/arm/plat-omap/include/plat/dmtimer.h          |   5 +-
>  6 files changed, 205 insertions(+), 1 deletion(-)

To me it seems we should wait on these until we have the clocks
coming from device tree. That leaves out some parts of this
patchset.

Regards,

Tony
