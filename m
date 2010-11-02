From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 2 Nov 2010 10:58:57 -0500
Subject: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <4CD03541.1010609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2010 11:15 AM, Ramirez Luna, Omar wrote:
> This is the patch series shared by Paul, for a short term fix to
> a compile break due SCM layer layer violations from tidspbridge
> driver, where the latter is used to write directly into registers
> and use SCM layer macros, among other layer bypassing.
>
> patch: "staging: tidspbridge: use new SCM DSP boot control fns"
> was split from its original version, it is meant to be on hold until
> the rest of the series gets upstreamed and can be found in the
> staging tree (unless best advice is given).
>
> Paul Walmsley (4):
>    OMAP: control: add functions for DSP boot address/mode control
>    OMAP3: PM: update DSP reset code to use new SCM DSP boot control
>      functions
>    OMAP: dsp: convert OMAP3430 adaptation layer to use new SCM DSP boot
>      control fns
>    staging: tidspbridge: use new SCM DSP boot control fns
>
>   arch/arm/mach-omap2/control.c                 |   51 ++++++++++++++++++++++
>   arch/arm/mach-omap2/control.h                 |   16 ++++---
>   arch/arm/mach-omap2/dsp.c                     |    4 ++
>   arch/arm/mach-omap2/pm34xx.c                  |    6 +-
>   arch/arm/plat-omap/include/plat/dsp.h         |    4 ++
>   arch/arm/plat-omap/include/plat/iva2_dsp.h    |   56 +++++++++++++++++++++++++
>   drivers/staging/tidspbridge/core/tiomap3430.c |   13 +++---
>   7 files changed, 133 insertions(+), 17 deletions(-)
>   create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h

This series was tested on OMAP 3430 (zoom2) and 3630 (zoom3) boards.

Regards,

Omar
