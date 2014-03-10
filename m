From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 14:14:39 +0000
Subject: [PATCH v9 1/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
In-Reply-To: <1393510711-4697-2-git-send-email-rogerq@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <1393510711-4697-2-git-send-email-rogerq@ti.com>
Message-ID: <20140310141439.GB15558@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Not all revisions have all the clocks so get the necessary clocks
> based on hardware revision.
> 
> This should avoid un-necessary clk_get failure messages that were
> observed earlier.
> 
> Also remove the dummy USB host clocks from the OMAP3 clock data.
> These are no longer expected by the driver.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Tero Kristo <t-kristo@ti.com>
> Acked-by: Mike Turquette <mturquette@linaro.org> [OMAP3 CLK data]
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/cclock3xxx_data.c |  4 ----
>  drivers/clk/ti/clk-3xxx.c             |  4 ----
>  drivers/mfd/omap-usb-host.c           | 43 ++++++++++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 19 deletions(-)

Patches starting to take shape. I know that I've reviewed this patch
before, so if you've fixed-up all my previous comments you can have my
Ack for the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
