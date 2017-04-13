From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Apr 2017 17:49:32 -0300
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CANMBJr7We9uOyE6=BCWoe9L7xRKjOG6ScgtDGEgQ-hPawPeppg@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
 <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
 <CANMBJr4BWtU7SXEa0-4LFLx+ydVWas0Cx18kRn-=-Bz8pPZ=fg@mail.gmail.com>
 <CAOMZO5BaKBsXean8-560HUuZbhjef9dpMNku0SRUVtkv+XsZ6w@mail.gmail.com>
 <CANMBJr7We9uOyE6=BCWoe9L7xRKjOG6ScgtDGEgQ-hPawPeppg@mail.gmail.com>
Message-ID: <CAOMZO5BjzSJws7zjJ5+aZkfeF+15twEu9zS3V+g6wQrtUiNyqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 5:13 PM, Tyler Baker <tyler.baker@linaro.org> wrote:

> I've rebased this series on the next-20170413 for sanity sake, and
> realized there doesn't appear to be a way to select CONFIG_IMX_GPCV2.
> I forced it using 'default y' and configured with imx_v6_v7_defconfig.
> Now my board is booting. Before this series is applied, it may be good
> to have CONFIG_IMX_GPCV2 selected specifically for iMX7 platform,
> otherwise there will be boot regressions.

Something like this?

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f03ef43..fe99a48 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -253,6 +253,7 @@ config RENESAS_H8S_INTC

 config IMX_GPCV2
  bool
+ def_bool y if SOC_IMX7D
  select IRQ_DOMAIN
  help
   Enables the wakeup IRQs for IMX platforms with GPCv2 block

>
> I'd encounter a backtrace with next-20170413 +  imx_v6_v7_defconfig +
> CONFIG_IMX_GPCV2=y
>
> Backtrace:
> [<c010c364>] (dump_backtrace) from [<c010c610>] (show_stack+0x18/0x1c)

but prior to fixing the Kconfig we need to fix this backtrace you reported.

Thanks
