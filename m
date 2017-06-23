From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 23 Jun 2017 09:04:16 +0800
Subject: [PATCH v3 0/3] Add RK3399 HDMI Support
In-Reply-To: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
References: <1496992228-10582-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <594C6910.6000208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for Heiko's review and Rob's Ack.

Seems no more confuse, pushed to drm-misc-next.

Thanks.

On 2017?06?09? 15:10, Mark Yao wrote:
> RK3399 and RK3288 shared the same HDMI IP controller, only some
> light difference with GRF configure, and an external VPLL clock
> need to configure.
>
> base on Yakir's v1 thread:
>     http://lkml.iu.edu/hypermail/linux/kernel/1607.1/01468.html
>
> rely on Jose's hdmi phy patch:
>     https://patchwork.kernel.org/patch/9702229
>
> Some Yakir's hdmi patches cause hdmi no display on my test,
> so I remove them on this thread.
>
> Tested on rk3399 evb board with kernel 4.12.0-rc1.
>
> Changes in v3:
>    remove hdmi_phy_configure_dwc_hdmi_3d_tx callbak.
>
> Changes in v2:
>    rebase to newest uptream, reuse hdmi_phy_configure_dwc_hdmi_3d_tx
>
> Mark Yao (3):
>    drm/rockchip: dw_hdmi: add RK3399 HDMI support
>    drm/rockchip: dw_hdmi: introduce the VPLL clock setting
>    drm/rockchip: dw_hdmi: introduce the pclk for grf
>
>   .../bindings/display/rockchip/dw_hdmi-rockchip.txt |   6 +-
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 110 ++++++++++++++++++---
>   2 files changed, 102 insertions(+), 14 deletions(-)
>


-- 
?ark Yao
