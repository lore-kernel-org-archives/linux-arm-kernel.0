From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 11 May 2017 10:20:01 -0700
Subject: [PATCH] ARM: remove duplicate 'const' annotations'
In-Reply-To: <20170511115059.2997141-1-arnd@arndb.de>
References: <20170511115059.2997141-1-arnd@arndb.de>
Message-ID: <d4e668df-3a3a-f246-8b57-6faf2600cf1a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2017 04:50 AM, Arnd Bergmann wrote:
> gcc-7 warns about some declarations that are more 'const' than necessary:
> 
> arch/arm/mach-at91/pm.c:338:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const ramc_ids[] __initconst = {
> arch/arm/mach-bcm/bcm_kona_smc.c:36:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
> arch/arm/mach-spear/time.c:207:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const timer_of_match[] __initconst = {
> arch/arm/mach-omap2/prm_common.c:714:34: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
> arch/arm/mach-omap2/vc.c:562:35: error: duplicate 'const' declaration specifier [-Werror=duplicate-decl-specifier]
>  static const struct i2c_init_data const omap4_i2c_timing_data[] __initconst = {
> 
> The ones in arch/arm were apparently all introduced accidentally by one
> commit that correctly marked a lot of variables as __initconst.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Fixes: 19c233b79d1a ("ARM: appropriate __init annotation for const data")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

>  arch/arm/mach-bcm/bcm_kona_smc.c | 2 +-

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
