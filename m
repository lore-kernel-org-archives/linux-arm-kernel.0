From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 22 Dec 2015 10:39:34 +0800
Subject: [PATCH 0/6] add rk3036 vop support
In-Reply-To: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
References: <1450323426-32109-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <5678B7E6.9040102@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
     I want to push these patches in a couple of days, So just Ping if 
anyone interested or have some doubt on it.

Thanks.
-Mark

On 2015?12?17? 11:37, Mark Yao wrote:
> This series of patches add rk3036 vop support.
>
> RK3036 registers layout is quite difference with rk3288 layout,
> The IC design with different framework, rk3036 vop is VOP LITE,
> and rk3288 is VOP FULL.
>
> RK3036 support two overlay plane and one hwc plane, max output
> resolution is 1080p. it support IOMMU, and its IOMMU same as
> rk3288's.
>
> This patches is based on drm/rockchip atomic patches. [0]
>
> Tested on kylin board, kylin runs on 4.1 kernel.
>
> backport to 4.1, and picked Yakir Yang's inno hdmi patches [1].
> works with test program atomictest[2] and modetest.
>
> [0]: https://lkml.org/lkml/2015/12/16/824
> [1]: https://lkml.org/lkml/2015/11/11/53
> [2]: https://github.com/markyzq/libdrm.git atomictest
>
> Mark Yao (6):
>    drm/rockchip: vop: merge vop cfg_done into vop_data
>    drm/rockchip: vop: move interrupt registers into vop_data
>    drm/rockchip: vop: spilt register related into rockchip_reg_vop.c
>    drm/rockchip: vop: spilt scale regsters to common and extension
>    drm/rockchip: vop: add rk3036 vop support
>    dt-bindings: add document for rk3036-vop
>
>   .../bindings/display/rockchip/rockchip-vop.txt     |    1 +
>   drivers/gpu/drm/rockchip/Makefile                  |    3 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  411 ++++----------------
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |  230 ++++++-----
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |  316 +++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |  169 ++++++++
>   6 files changed, 696 insertions(+), 434 deletions(-)
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_vop_reg.h
>
