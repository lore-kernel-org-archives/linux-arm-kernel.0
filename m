From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 13 Jan 2017 09:27:06 +0800
Subject: [PATCH v20 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
References: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1484270826.14822.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-04 at 11:06 +0800, HS Liao wrote:
> Hi,
> 
> This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
> to help write registers with critical time limitation, such as
> updating display configuration during the vblank. It controls Global
> Command Engine (GCE) hardware to achieve this requirement.
> 
> These patches have a build dependency on top of v4.10-rc2.
> 
> Changes since v19:
>  - rebase to v4.10-rc2
> 
> Best regards,
> HS Liao
> 
> HS Liao (4):
>   dt-bindings: soc: Add documentation for the MediaTek GCE unit
>   mailbox: mediatek: Add Mediatek CMDQ driver
>   arm64: dts: mt8173: Add GCE node
>   soc: mediatek: Add Mediatek CMDQ helper
> 
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  43 ++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
>  drivers/mailbox/Kconfig                            |  10 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/mtk-cmdq-mailbox.c                 | 596 +++++++++++++++++++++
>  drivers/soc/mediatek/Kconfig                       |  12 +
>  drivers/soc/mediatek/Makefile                      |   1 +
>  drivers/soc/mediatek/mtk-cmdq-helper.c             | 310 +++++++++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h           |  75 +++
>  include/linux/soc/mediatek/mtk-cmdq.h              | 174 ++++++
>  10 files changed, 1233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
>  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
>  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> 

Hi Jassi, Matthias,

Sorry to disturb you.
Do you have any further comments on CMDQ v20?

Thanks.
HS
