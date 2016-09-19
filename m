From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Mon, 19 Sep 2016 14:43:59 +0800
Subject: [PATCH v14 0/4] Mediatek MT8173 CMDQ support
In-Reply-To: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1474267439.23652.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-09-05 at 09:44 +0800, HS Liao wrote:
> Hi,
> 
> This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
> to help write registers with critical time limitation, such as
> updating display configuration during the vblank. It controls Global
> Command Engine (GCE) hardware to achieve this requirement.
> 
> These patches have a build dependency on top of v4.8-rc1.
> 
> Changes since v13:
>  - move to mailbox folder
>  - simplify cmdq_thread_is_in_wfe
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
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  43 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
>  drivers/mailbox/Kconfig                            |  10 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/mtk-cmdq.c                         | 965 +++++++++++++++++++++
>  include/linux/mailbox/mtk-cmdq.h                   | 180 ++++
>  6 files changed, 1210 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
>  create mode 100644 drivers/mailbox/mtk-cmdq.c
>  create mode 100644 include/linux/mailbox/mtk-cmdq.h
> 

Hi Jassi,

Sorry to disturb you.
Do you have any further comment on CMDQ v14?

Thanks.
HS
