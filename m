From: j-keerthy@ti.com (Keerthy)
Date: Wed, 19 Sep 2018 13:20:59 +0530
Subject: [PATCH v3 RESEND 0/4] clk: clk: Add functions to save/restore
 clock context en-masse
In-Reply-To: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
References: <1536043778-2232-1-git-send-email-j-keerthy@ti.com>
Message-ID: <2b898faf-ca7d-1ef9-f862-9a3f05717884@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 04 September 2018 12:19 PM, Keerthy wrote:
> Deep enough power saving mode can result into losing context of the clock
> registers also, and they need to be restored once coming back from the power
> saving mode. Hence add functions to save/restore clock context.

A gentle ping on this series.

> 
> Tested for DS0 on am437x-gp-evm
> 
> Based on top of linux-next
> 
> Resend Series:
> 
>   * Rebased on top of Linux 4.19-rc2
>   * Added Tony's Ack.
> 
> Changes in v2:
> 
>         * Renamed clk_dflt_restore to clk_gate_restore_context
> 
> Changes in v3: Corrected the e-mail address of linux-omap list 
> 
> Keerthy (2):
>   clk: clk: Add clk_gate_restore_context function
>   ti: pm33xx: Save/restore clk context based on enable_off_mode setting
> 
> Russ Dill (2):
>   clk: clk: Add functions to save/restore clock context en-masse
>   clk: ti: Add functions to save/restore clk context
> 
>  arch/arm/mach-omap2/pm33xx-core.c    |  15 +++++
>  drivers/clk/clk.c                    |  93 ++++++++++++++++++++++++++
>  drivers/clk/ti/clock.h               |   2 +
>  drivers/clk/ti/divider.c             |  36 ++++++++++
>  drivers/clk/ti/dpll.c                |   6 ++
>  drivers/clk/ti/dpll3xxx.c            | 124 +++++++++++++++++++++++++++++++++++
>  drivers/clk/ti/gate.c                |   3 +
>  drivers/clk/ti/mux.c                 |  29 ++++++++
>  drivers/soc/ti/pm33xx.c              |  13 ++++
>  include/linux/clk-provider.h         |   9 +++
>  include/linux/clk.h                  |  25 +++++++
>  include/linux/clk/ti.h               |   6 ++
>  include/linux/platform_data/pm33xx.h |   1 +
>  13 files changed, 362 insertions(+)
> 
