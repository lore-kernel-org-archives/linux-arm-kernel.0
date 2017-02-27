From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 27 Feb 2017 09:41:26 +0800
Subject: [PATCH v4 00/23] drm/rockchip: MIPI fixes & improvements
In-Reply-To: <20170224125506.21533-1-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
Message-ID: <58B383C6.5050204@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?24? 20:54, John Keeping wrote:
> This version is mostly small changes in response to review comments from
> Sean and Chris, the details are in the individual patches.
>
> I decided to drop the final patch which adds support for MIPI read
> commands because I'm not using that feature now and I can't easily test
> it.  It's on the list if anyone wants to pick it up in the future.
>
> Version 3 was posted here:
> http://www.spinics.net/lists/dri-devel/msg130977.html
>
> Thanks to Sean Paul and Chris Zhong for their review and testing of this
> series.

Looks good to me.

Acked-by: Mark Yao <mark.yao@rock-chips.com>

>
> John Keeping (23):
>    drm/rockchip: dw-mipi-dsi: don't configure hardware in mode_set for
>      MIPI
>    drm/rockchip: dw-mipi-dsi: pass mode in where needed
>    drm/rockchip: dw-mipi-dsi: remove mode_set hook
>    drm/rockchip: dw-mipi-dsi: fix command header writes
>    drm/rockchip: dw-mipi-dsi: fix generic packet status check
>    drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read on tx_buf
>    drm/rockchip: dw-mipi-dsi: include bad value in error message
>    drm/rockchip: dw-mipi-dsi: respect message flags
>    drm/rockchip: dw-mipi-dsi: only request HS clock when required
>    drm/rockchip: dw-mipi-dsi: don't assume buffer is aligned
>    drm/rockchip: dw-mipi-dsi: prepare panel after phy init
>    drm/rockchip: dw-mipi-dsi: allow commands in panel_disable
>    drm/rockchip: dw-mipi-dsi: fix escape clock rate
>    drm/rockchip: dw-mipi-dsi: ensure PHY is reset
>    drm/rockchip: dw-mipi-dsi: configure PHY before enabling
>    drm/rockchip: dw-mipi-dsi: properly configure PHY timing
>    drm/rockchip: dw-mipi-dsi: improve PLL configuration
>    drm/rockchip: dw-mipi-dsi: use specific poll helper
>    drm/rockchip: dw-mipi-dsi: use positive check for N{H,V}SYNC
>    drm/rockchip: vop: test for P{H,V}SYNC
>    drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
>    drm/rockchip: dw-mipi-dsi: support non-burst modes
>    drm/rockchip: dw-mipi-dsi: add reset control
>
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c      | 325 +++++++++++++++++++---------
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   4 +-
>   2 files changed, 220 insertions(+), 109 deletions(-)
>


-- 
?ark Yao
