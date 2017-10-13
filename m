From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 13 Oct 2017 10:28:07 +0800
Subject: [PATCH] drm/rockchip: add PINCTRL dependency for LVDS
In-Reply-To: <20171005120957.485433-1-arnd@arndb.de>
References: <20171005120957.485433-1-arnd@arndb.de>
Message-ID: <c0d08177-00b6-7d20-5fd0-5d4a9b3c2b7b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?10?05? 20:09, Arnd Bergmann wrote:
> The new driver fails to build when CONFIG_PINCTRL is disabled:
>
> drivers/gpu/drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_grf_config':
> drivers/gpu/drm/rockchip/rockchip_lvds.c:229:39: error: dereferencing pointer to incomplete type 'struct dev_pin_info'
>     if (lvds->pins && !IS_ERR(lvds->pins->default_state))
>
> This adds the respective Kconfig dependency.
>
> Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Pushed to drm-misc-next

Thanks
Mark
