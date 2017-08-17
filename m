From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:33:41 -0500
Subject: [PATCH 1/8] dt-bindings: mediatek: Add binding for mt2712 IOMMU
 and SMI
In-Reply-To: <1502445377-26936-2-git-send-email-yong.wu@mediatek.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
 <1502445377-26936-2-git-send-email-yong.wu@mediatek.com>
Message-ID: <20170817153220.52mt3jjgyktydeln@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 05:56:10PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt2712 IOMMU and SMI.
> 
> In order to balance the bandwidth, mt2712 has two M4Us, two
> smi-commons, 8 smi-larbs. and mt2712 is also MTK IOMMU gen2 which
> use Short-Descriptor translation table format.

s/use/uses/

> 
> The mt2712 M4U-SMI HW diagram is as below:
> 
>                             EMI
>                              |
>               -------------------------------
>               |                             |
>              M4U0                          M4U1
>               |                             |
>          smi-common0                   smi-common1
>               |                             |
>   -------------------------       --------------------
>   |     |     |     |     |       |         |        |
>   |     |     |     |     |       |         |        |
> larb0 larb1 larb2 larb3 larb6    larb4    larb5     larb7
> disp0 vdec  cam   venc   jpg  mdp1/disp1 mdp2/disp2  mdp3->larb names
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  6 +-
>  .../memory-controllers/mediatek,smi-common.txt     |  6 +-
>  .../memory-controllers/mediatek,smi-larb.txt       |  5 +-
>  include/dt-bindings/memory/mt2712-larb-port.h      | 91 ++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h

Acked-by: Rob Herring <robh@kernel.org>
