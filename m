From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Aug 2012 13:41:32 +0000
Subject: [PATCH 2/4] arm: plat-orion: make bridge_virt_base non-const to
 support DT use case
In-Reply-To: <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201208031341.32744.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 August 2012, Thomas Petazzoni wrote:
> diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/plat-orion/include/plat/addr-map.h
> index fd556f7..aafdd79 100644
> --- a/arch/arm/plat-orion/include/plat/addr-map.h
> +++ b/arch/arm/plat-orion/include/plat/addr-map.h
> @@ -16,7 +16,7 @@ extern struct mbus_dram_target_info orion_mbus_dram_info;
>  struct orion_addr_map_cfg {
>         const int num_wins;     /* Total number of windows */
>         const int remappable_wins;
> -       const u32 bridge_virt_base;
> +       u32 bridge_virt_base;
>  
>         /* If NULL, the default cpu_win_can_remap will be used, using
>            the value in remappable_wins */

It would be nice to also change the type of this to void __iomem*, since you are
already touching the bridge_virt_base.

	Arnd
