From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Fri, 10 Jun 2016 17:15:09 +0800
Subject: Add MediaTek USB3 DRD Driver
In-Reply-To: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1465543962-11678-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1465550109.11651.147.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Fri, 2016-06-10 at 15:32 +0800, Chunfeng Yun wrote:
> From 8fdc924cecf0ca14da6e8aba360501e53437e548 Mon Sep 17 00:00:00 2001
> From: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Date: Fri, 10 Jun 2016 15:20:20 +0800
> Subject: [PATCH 0/5] Add MediaTek USB3 DRD Driver
> 
> These patches introduce the MediaTek USB3 dual-role controller
> driver.
> 
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only (xHCI) modes. It works well
> with Mass Storage, RNDIS and g_zero on FS/HS and SS. And it is
> tested on MT8173 platform which only contains USB2.0 device IP,
> and on MT6290 platform which contains USB3.0 device IP.
> 
> Change in v3:
> 1. fix some typo error
> 2. rename mtu3.txt to mt8173-mtu3.txt
> 
> Change in v2:
> 1. modify binding docs according to suggestions
> 2. modify some comments and remove some dummy blank lines
> 3. fix memory leakage
> 
> Chunfeng Yun (5):
>   dt-bindings: mt8173-xhci: support host side of dual-role mode
>   dt-bindings: mt8173-mtu3: add devicetree bindings

Could you please help me to review the following two patches based on
v4.7-rc1:
  1- usb: xhci-mtk: make IPPC register optional
  2- usb: Add MediaTek USB3 DRD Driver

Thank you very much

>   usb: xhci-mtk: make IPPC register optional
>   usb: Add MediaTek USB3 DRD Driver
>   arm64: dts: mediatek: add USB3 DRD driver
> 
>  .../devicetree/bindings/usb/mt8173-mtu3.txt        |   85 ++
>  .../devicetree/bindings/usb/mt8173-xhci.txt        |   48 ++
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   46 +-
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   28 +-
>  drivers/usb/Kconfig                                |    2 +
>  drivers/usb/Makefile                               |    1 +
>  drivers/usb/host/xhci-mtk.c                        |   32 +-
>  drivers/usb/mtu3/Kconfig                           |   47 ++
>  drivers/usb/mtu3/Makefile                          |   20 +
>  drivers/usb/mtu3/mtu3.h                            |  422 ++++++++++
>  drivers/usb/mtu3/mtu3_core.c                       |  879 ++++++++++++++++++++
>  drivers/usb/mtu3/mtu3_dr.c                         |  348 ++++++++
>  drivers/usb/mtu3/mtu3_dr.h                         |  108 +++
>  drivers/usb/mtu3/mtu3_gadget.c                     |  731 ++++++++++++++++
>  drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  879 ++++++++++++++++++++
>  drivers/usb/mtu3/mtu3_host.c                       |  294 +++++++
>  drivers/usb/mtu3/mtu3_hw_regs.h                    |  474 +++++++++++
>  drivers/usb/mtu3/mtu3_plat.c                       |  490 +++++++++++
>  drivers/usb/mtu3/mtu3_qmu.c                        |  599 +++++++++++++
>  drivers/usb/mtu3/mtu3_qmu.h                        |   43 +
>  20 files changed, 5562 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/mt8173-mtu3.txt
>  create mode 100644 drivers/usb/mtu3/Kconfig
>  create mode 100644 drivers/usb/mtu3/Makefile
>  create mode 100644 drivers/usb/mtu3/mtu3.h
>  create mode 100644 drivers/usb/mtu3/mtu3_core.c
>  create mode 100644 drivers/usb/mtu3/mtu3_dr.c
>  create mode 100644 drivers/usb/mtu3/mtu3_dr.h
>  create mode 100644 drivers/usb/mtu3/mtu3_gadget.c
>  create mode 100644 drivers/usb/mtu3/mtu3_gadget_ep0.c
>  create mode 100644 drivers/usb/mtu3/mtu3_host.c
>  create mode 100644 drivers/usb/mtu3/mtu3_hw_regs.h
>  create mode 100644 drivers/usb/mtu3/mtu3_plat.c
>  create mode 100644 drivers/usb/mtu3/mtu3_qmu.c
>  create mode 100644 drivers/usb/mtu3/mtu3_qmu.h
> 
> --
> 1.7.9.5
> 
> 
