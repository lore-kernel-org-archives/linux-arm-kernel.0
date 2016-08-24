From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Aug 2016 13:00:34 +0200
Subject: [PATCH v13 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
References: <1472009252-1074-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <20b10079-3ae2-9da9-1149-0bceabac9837@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/08/16 05:27, HS Liao wrote:
>
> Hi,
>
> This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
> to help write registers with critical time limitation, such as
> updating display configuration during the vblank. It controls Global
> Command Engine (GCE) hardware to achieve this requirement.
>
> These patches have a build dependency on top of v4.8-rc1.
>
> Changes since v12:
>  - remove mediatek,gce from device tree

Why? The binding got accepted by Rob.

>
> Best regards,
> HS Liao
>
> HS Liao (4):
>   dt-bindings: soc: Add documentation for the MediaTek GCE unit
>   CMDQ: Mediatek CMDQ driver
>   arm64: dts: mt8173: Add GCE node
>   CMDQ: save more energy in idle
>
>  .../devicetree/bindings/soc/mediatek/gce.txt       |  44 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
>  drivers/soc/mediatek/Kconfig                       |  11 +
>  drivers/soc/mediatek/Makefile                      |   1 +
>  drivers/soc/mediatek/mtk-cmdq.c                    | 983 +++++++++++++++++++++

The driver uses the mailbox framework, so it should live in the 
drivers/mailbox folder.

Please don't forget to add Jassi to the loop, as he is the maintainer of 
this subsystem and the last instance to decide if/when the driver will 
get accepted.

Thanks,
Matthias

>  include/soc/mediatek/cmdq.h                        | 180 ++++
>  6 files changed, 1229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq.c
>  create mode 100644 include/soc/mediatek/cmdq.h
>
