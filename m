From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 May 2013 11:44:43 -0700
Subject: [PATCH v2 0/5] Zynq: revised CCF code
In-Reply-To: <51961F37.3030202@monstr.eu>
References: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com>
 <51961F37.3030202@monstr.eu>
Message-ID: <20130530184443.4470.73215@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Michal Simek (2013-05-17 05:14:47)
> Hi Mike,
> 
> I have sent email to Greg to take this patch from this series
> though his serial tree because it is unrelated to this clock stuff.
> 
> Can you please give me your ACK for these patches or add them
> to your CLK tree?
> 

For the four clock-related patches:

Acked-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

> I just need to move this to be able to start to push other drivers
> which are related to this.
> 
> Thanks,
> Michal
> 
> 
> On 05/13/2013 07:46 PM, Soren Brinkmann wrote:
> > I rebased this series on v3.10-rc1 eliminating all dependencies and incorporated
> > Greg's feedback.
> > I'll push this also to my github repository.
> > https://github.com/sorenb-xlnx/linux-xlnx/tree/zynq/clkc
> > 
> > v2:
> >  - dropped the 'sort #includes' patches
> > 
> >       S?ren
> > 
> > 
> > Soren Brinkmann (5):
> >   tty: xuartps: Remove suspend/resume functions
> >   clk: zynq: Factor out PLL driver
> >   clk: zynq: Add clock controller driver
> >   arm: zynq: Migrate platform to clock controller
> >   clk: zynq: Remove deprecated clock code
> > 
> >  .../devicetree/bindings/clock/zynq-7000.txt        | 127 +++--
> >  arch/arm/boot/dts/zynq-7000.dtsi                   |  71 +--
> >  arch/arm/boot/dts/zynq-zc702.dts                   |   4 -
> >  arch/arm/mach-zynq/slcr.c                          |   2 +-
> >  drivers/clk/Makefile                               |   2 +-
> >  drivers/clk/clk-zynq.c                             | 378 ---------------
> >  drivers/clk/zynq/Makefile                          |   3 +
> >  drivers/clk/zynq/clkc.c                            | 533 +++++++++++++++++++++
> >  drivers/clk/zynq/pll.c                             | 235 +++++++++
> >  drivers/clocksource/cadence_ttc_timer.c            |  23 +-
> >  drivers/tty/serial/xilinx_uartps.c                 | 115 +++--
> >  include/linux/clk/zynq.h                           |   8 +-
> >  12 files changed, 974 insertions(+), 527 deletions(-)
> >  delete mode 100644 drivers/clk/clk-zynq.c
> >  create mode 100644 drivers/clk/zynq/Makefile
> >  create mode 100644 drivers/clk/zynq/clkc.c
> >  create mode 100644 drivers/clk/zynq/pll.c
> > 
> 
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
