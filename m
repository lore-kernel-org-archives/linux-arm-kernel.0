From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 18:33:16 -0500
Subject: [PATCH v2 1/8] dt-bindings: mediatek: Add binding for mt2712
 IOMMU and SMI
In-Reply-To: <1503313221-26453-2-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
 <1503313221-26453-2-git-send-email-yong.wu@mediatek.com>
Message-ID: <20170821233316.n3wbdafmo45fbnhe@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 07:00:14PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt2712 IOMMU and SMI.
> 
> In order to balance the bandwidth, mt2712 has two M4Us, two
> smi-commons, 10 smi-larbs. and mt2712 is also MTK IOMMU gen2 which
> uses ARM Short-Descriptor translation table format.
> 
> The mt2712 M4U-SMI HW diagram is as below:
> 
>                             EMI
>                              |
>               ------------------------------------
>               |                                  |
>              M4U0                              M4U1
>               |                                  |
>          smi-common0                        smi-common1
>               |                                  |
>   -------------------------       --------------------------------
>   |     |     |     |     |       |         |        |     |     |
>   |     |     |     |     |       |         |        |     |     |
> larb0 larb1 larb2 larb3 larb6    larb4    larb5    larb7 larb8 larb9
> disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2 mdp3 vdo/nr tvd
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Rob,
>     Comparing with the v1, I add larb8 and larb9 in this version.
>     So I don't add your ACK here.

Thanks for the explanation. That's minor enough you could have kept it.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |   6 +-
>  .../memory-controllers/mediatek,smi-common.txt     |   6 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |   5 +-
>  include/dt-bindings/memory/mt2712-larb-port.h      | 102 +++++++++++++++++++++
>  4 files changed, 113 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
