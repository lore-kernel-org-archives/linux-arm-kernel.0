From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 21:13:19 -0600
Subject: [PATCH 0/7] Move Qualcomm gpio drivers into drivers dir
In-Reply-To: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20110527031319.GH5032@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 02:50:46PM -0700, David Brown wrote:
> This patch series moves the Qualcomm MSM gpio device drivers into the
> drivers/gpio directory.
> 
> The MSM's have two flavors of gpio driver.  The one for the newer
> v7-based chips is a bit cleaner, and can just be moved.  The one for
> the older v6-based chips took some cleanup to get rid of numerous
> ifdefs based on the particular machine.  Both drivers can now be
> selected and will be used on appropriate targets.
> 
> There is still a minor entanglement with the MSM-specific gpiomux
> code.  This will be cleaned up as MSM moves to use pinmux.
> 
> David Brown (7):
>   msm: gpio: Remove unsupported devices
>   msm: Remove chip-ifdefs for GPIO io mappings
>   msm: gpio: Remove chip-specific register definitions
>   msm: gpio: Remove ifdefs on gpio chip registers
>   msm: gpiomux: Move public API to public header
>   gpio_msm: Move Qualcomm v6 MSM driver into drivers
>   gpio_msm: Move Qualcomm MSM v2 gpio driver into drivers

What's the status of this series.  I only got cc'd on the last two
patches; did you want me to pick up the whole lot, or is it being
merged via the msm tree?

Alternately, if there is a git branch with these patches in it, then I
can merge that instead of applying individually.

g.

> 
>  arch/arm/mach-msm/Kconfig                       |    4 +
>  arch/arm/mach-msm/Makefile                      |    8 -
>  arch/arm/mach-msm/gpio-v2.c                     |  427 -----------------------
>  arch/arm/mach-msm/gpio.c                        |  376 --------------------
>  arch/arm/mach-msm/gpio_hw.h                     |  278 ---------------
>  arch/arm/mach-msm/gpiomux.h                     |   17 +-
>  arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |   10 +-
>  arch/arm/mach-msm/include/mach/msm_iomap.h      |    2 +
>  arch/arm/mach-msm/io.c                          |   12 +-
>  drivers/gpio/Kconfig                            |   16 +
>  drivers/gpio/Makefile                           |    2 +
>  drivers/gpio/msm_v1.c                           |  387 ++++++++++++++++++++
>  drivers/gpio/msm_v1.h                           |  271 ++++++++++++++
>  drivers/gpio/msm_v2.c                           |  427 +++++++++++++++++++++++
>  include/linux/msm_gpiomux.h                     |   38 ++
>  17 files changed, 1166 insertions(+), 1129 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/gpio-v2.c
>  delete mode 100644 arch/arm/mach-msm/gpio.c
>  delete mode 100644 arch/arm/mach-msm/gpio_hw.h
>  create mode 100644 drivers/gpio/msm_v1.c
>  create mode 100644 drivers/gpio/msm_v1.h
>  create mode 100644 drivers/gpio/msm_v2.c
>  create mode 100644 include/linux/msm_gpiomux.h
> 
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
