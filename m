From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 11 Nov 2016 17:34:58 +0800
Subject: [PATCH v16 0/5] Mediatek MT8173 CMDQ support
In-Reply-To: <CABb+yY3mi3M0xqNao=DRYN6Np0LOBfS669iUa_hWo2w1MmM1sw@mail.gmail.com>
References: <1477999698-6288-1-git-send-email-hs.liao@mediatek.com>
 <1478776558.15447.2.camel@mtksdaap41>
 <CABb+yY3mi3M0xqNao=DRYN6Np0LOBfS669iUa_hWo2w1MmM1sw@mail.gmail.com>
Message-ID: <1478856898.8781.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-11 at 11:15 +0530, Jassi Brar wrote:
> On Thu, Nov 10, 2016 at 4:45 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> > On Tue, 2016-11-01 at 19:28 +0800, HS Liao wrote:
> >> Hi,
> >>
> >> This is Mediatek MT8173 Command Queue(CMDQ) driver. The CMDQ is used
> >> to help write registers with critical time limitation, such as
> >> updating display configuration during the vblank. It controls Global
> >> Command Engine (GCE) hardware to achieve this requirement.
> >>
> >> These patches have a build dependency on top of v4.9-rc1.
> >>
> >> Changes since v15:
> >>  - separate "suspend and resume" patch from "save energy" patch
> >>  - don't stop running tasks in cmdq_suspend()
> >>    (i.e. leave no running tasks guarantee to clients)
> >>
> >> Best regards,
> >> HS Liao
> >>
> >> HS Liao (5):
> >>   dt-bindings: soc: Add documentation for the MediaTek GCE unit
> >>   CMDQ: Mediatek CMDQ driver
> >>   arm64: dts: mt8173: Add GCE node
> >>   CMDQ: suspend and resume
> >>   CMDQ: save energy
> >>
> >>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  43 ++
> >>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  10 +
> >>  drivers/mailbox/Kconfig                            |  10 +
> >>  drivers/mailbox/Makefile                           |   2 +
> >>  drivers/mailbox/mtk-cmdq-mailbox.c                 | 632 +++++++++++++++++++++
> >>  drivers/soc/mediatek/Kconfig                       |  11 +
> >>  drivers/soc/mediatek/Makefile                      |   1 +
> >>  drivers/soc/mediatek/mtk-cmdq-helper.c             | 310 ++++++++++
> >>  include/linux/mailbox/mtk-cmdq-mailbox.h           |  67 +++
> >>  include/linux/soc/mediatek/mtk-cmdq.h              | 182 ++++++
> >>  10 files changed, 1268 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> >>  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
> >>  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> >>  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
> >>  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> >>
> >
> >
> > Hi Jassi, Matthias,
> >
> > Sorry to disturb you.
> >
> No, you don't disturb, but the controller driver and protocol driver,
> introduced in the same patch, does :)   So does the suspend/resume
> support (patch 4&5) added  separately as a patch on top. Please
> reorganise the patchset.
> 
> Thanks.

Hi Jassi,

Do you mean
1. split controller driver and protocol driver as two patches,
2. merge patch 4&5 into one patch, and
3. reorganize the patchset as "(1) binding doc (2) controller driver
   (3) protocol driver (4) devicetree (5) energy patch" ?

Thanks,
HS
