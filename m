From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 1 Aug 2011 12:50:39 +0100
Subject: [GIT PULL] msm gpio move to drivers/gpio
In-Reply-To: <20110801112244.GA24384@huya.qualcomm.com>
References: <20110801112244.GA24384@huya.qualcomm.com>
Message-ID: <20110801115039.GA2191@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 04:22:45AM -0700, David Brown wrote:
> The following changes since commit 02f8c6aee8df3cdc935e9bdd4f2d020306035dbe:
> 
>   Linux 3.0 (2011-07-21 19:17:23 -0700)
> 
> are available in the git repository at:
>   git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-move-gpio
> 
> David Brown (7):
>       msm: gpio: Remove unsupported devices
>       msm: Remove chip-ifdefs for GPIO io mappings
>       msm: gpio: Remove chip-specific register definitions
>       msm: gpio: Remove ifdefs on gpio chip registers
>       msm: gpiomux: Move public API to public header
>       gpio_msm: Move Qualcomm v6 MSM driver into drivers
>       gpio_msm: Move Qualcomm MSM v2 gpio driver into drivers
> 
>  arch/arm/mach-msm/Kconfig                          |    4 +
>  arch/arm/mach-msm/Makefile                         |    8 -
>  arch/arm/mach-msm/gpio_hw.h                        |  278 --------------------
>  arch/arm/mach-msm/gpiomux.h                        |   17 +--
>  arch/arm/mach-msm/include/mach/msm_gpiomux.h       |   38 +++
>  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h    |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap-7x30.h    |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap-8x50.h    |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap.h         |    2 +
>  arch/arm/mach-msm/io.c                             |   12 +-
>  drivers/gpio/Kconfig                               |   16 ++
>  drivers/gpio/Makefile                              |    2 +
>  arch/arm/mach-msm/gpio.c => drivers/gpio/msm_v1.c  |  111 +++++----
>  drivers/gpio/msm_v1.h                              |  271 +++++++++++++++++++
>  .../mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c    |    2 +-

As discussed f2f at linaro Connect: filenames in drivers/gpio/ should be "gpio-*.{c,h}

g.

>  15 files changed, 414 insertions(+), 377 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/gpio_hw.h
>  create mode 100644 arch/arm/mach-msm/include/mach/msm_gpiomux.h
>  rename arch/arm/mach-msm/gpio.c => drivers/gpio/msm_v1.c (82%)
>  create mode 100644 drivers/gpio/msm_v1.h
>  rename arch/arm/mach-msm/gpio-v2.c => drivers/gpio/msm_v2.c (99%)
> 
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
