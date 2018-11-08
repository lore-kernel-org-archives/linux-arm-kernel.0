From: jbrunet@baylibre.com (jbrunet at baylibre.com)
Date: Thu, 08 Nov 2018 14:34:37 +0100
Subject: [PATCH v4 0/2] clk: meson-g12a: Add EE clock controller driver
In-Reply-To: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
References: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
Message-ID: <1157f0a9419eea01c099d8dc08d7757593720286.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-11-08 at 21:15 +0800, Jian Hu wrote:
> Changes since v3 at[4]
> -add fixed clocks clk_regmap definition

Jian,

When replying to the v1 of your clk_ao patchset : 
https://patchwork.kernel.org/patch/10562563/#22177627

I have explained that I would like to stop taking clock (such as xtal) from
nowhere. Clocks (even the xtal) should be properly claimed through DT.
I have specifically asked this to be taken into account for the EE controller.

If you need an exemple on how to get the input clock from DT to your
controller, please have look at the axg audio clock controller.

This comment does not appear to be addressed in this version. 
Please make sure you have addressed all the comments of past reviews before
reposting

Thx

> 
> Changes since v2 at[2]
> -fix fixed clocks's descriptions
> -fix aligment
> -add enable bit for plls base on [3] patches
> -add fixed clock gate bit
> 
> Changes since v1 at[1]
> -fix typo of 'Everything'.
> -change the word 'AmLogic' to 'Amlogic'
> -squash patch 1 and 2.
> -delete usless message of "Trying obsolete regs".
> -delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
> -rebase on top of the "next/drivers" branch, and add g12a clock patch.
> -add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
>  g12a_sd_emmc_c_clk0_sel.
> 
> [1]
> https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu at amlogic.com
> [2]
> https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu at amlogic.com
> [3]https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet at baylibre.com
> [4]
> https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu at amlogic.com
> 
> Jian Hu (2):
>   dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
>   clk: meson-g12a: Add EE Clock controller driver
> 
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
>  drivers/clk/meson/Kconfig                          |   10 +
>  drivers/clk/meson/Makefile                         |    1 +
>  drivers/clk/meson/g12a.c                           | 1134
> ++++++++++++++++++++
>  drivers/clk/meson/g12a.h                           |  128 +++
>  include/dt-bindings/clock/g12a-clkc.h              |   93 ++
>  6 files changed, 1367 insertions(+)
>  create mode 100644 drivers/clk/meson/g12a.c
>  create mode 100644 drivers/clk/meson/g12a.h
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h
> 
