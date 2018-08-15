From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 15 Aug 2018 09:55:29 +0800
Subject: [PATCH v4 00/14] Add RDMA memory mode support for mediatek SOC
 MT2712
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <1534298129.29201.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stu:

For the series, applied to mediatek-drm-next-4.19 [1], but I modified
'drm/mediatek: add RGB color format support for RDMA' and 'drm/mediatek:
add YUYV/UYVY color format support for RDMA' because I would like to
place related register definition together.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-4.19

Regards,
CK

On Thu, 2018-08-09 at 10:15 +0800, Stu Hsieh wrote:
> This patch series add RDMA memory mode support for mediatek SOC MT2712.
> MT2712 has three display data path, including three HW engine,
> two OVL and one RDMA.
> 
> The RDMA used in third ddp and it need to be set memory mode,
> then RDMA could read data from memory and output to panel.
> 
> Change in v4:
> - Add the comment about naming color format definition for RDMA in patch
>   "drm/mediatek: add memory mode and layer_config for RDMA"
> - Add the comment about naming color format definition for OVL in patch
>   "drm/mediatek: add the comment about color format setting for OVL"
> - Update the naming about matrix definition and Symbolize the mask in patch
>   "drm/mediatek: add YUYV/UYVY color format support for RDMA"
> - remove the word "callback" for title in patch
>   "drm/mediatek: add function to return OVL layer number" and
>   "drm/mediatek: add function to return RDMA layer number"
> - Use single pointer to declare the planes array in patch
>   "drm/mediatek: use layer_nr function to get layer number to init plane"
> 
> Stu Hsieh (14):
>   drm/mediatek: add connection from RDMA0 to DPI1
>   drm/mediatek: add connection from RDMA0 to DSI1
>   drm/mediatek: add connection from RDMA1 to DSI0
>   drm/mediatek: add connection from RDMA2 to DSI0
>   drm/mediatek: add memory mode and layer_config for RDMA
>   drm/mediatek: add RGB color format support for RDMA
>   drm/mediatek: add the comment about color format setting for OVL
>   drm/mediatek: add YUYV/UYVY color format support for RDMA
>   drm/mediatek: add function to get layer number for component
>   drm/mediatek: add function to return OVL layer number
>   drm/mediatek: add function to return RDMA layer number
>   drm/mediatek: use layer_nr function to get layer number to init plane
>   drm/mediatek: update some variable name from ovl to comp
>   drm/mediatek: fix connection from RDMA2 to DSI1
> 
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 11 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 93 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 47 ++++++++-------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 +++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 +++
>  6 files changed, 158 insertions(+), 23 deletions(-)
> 
