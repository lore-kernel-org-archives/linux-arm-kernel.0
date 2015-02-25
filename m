From: dtor@chromium.org (Dmitry Torokhov)
Date: Wed, 25 Feb 2015 11:33:46 -0800
Subject: [PATCH v5 0/6] Add common clock support for Broadcom iProc
 architecture
In-Reply-To: <1423097705-22939-1-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
Message-ID: <20150225193346.GD3215@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 04:54:59PM -0800, Ray Jui wrote:
> This patchset contains the initial common clock support for Broadcom's iProc
> family of SoCs. The iProc clock architecture comprises of various PLLs, e.g.,
> ARMPLL, GENPLL, LCPLL0, MIPIPLL, and etc. An onboard crystal serves as the
> basic reference clock for these PLLs. Each PLL may have several leaf clocks.
> One special group of clocks is the ASIU clocks, which are dervied directly
> from the crystal reference clock.
> 
> This patchset also contains the basic clock support for the Broadcom Cygnus
> SoC, which implements the iProc clock architecture
> 
> Changes from v4:
>  - Add of_clk_get_parent_rate helper function into the clock framework
>  - Switch to use of_clk_get_parent_rate in the iProc PLL clock driver
> 
> Changes from v3:
>  - Fix incorrect use of passing in of_clk_src_onecell_get when adding ARM PLL
>    and other iProc PLLs as clock provider. These PLLs have zero cells in DT and
>    thefore of_clk_src_simple_get should be used instead
>  - Rename Cygnus MIPI PLL Channel 2 clock from BCM_CYGNUS_MIPIPLL_CH2_UNUSED
>    to BCM_CYGNUS_MIPIPLL_CH2_V3D, since a 3D graphic rendering engine has been
>    integrated into Cygnus revision B0 and has its core clock running off
>    MIPI PLL Channel 2
>  - Changed default MIPI PLL VCO frequency from 1.75 GHz to 2.1 GHz. This allows
>    us to derive 300 MHz V3D clock from channel 2 through the post divisor
> 
> Changes from v2:
>  - Re-arrange Cygnus clock/pll init functions so each init function is right
>    next to its clock table
>  - Removed #defines for number of clocks in Cygnus. Have the number of clocks
>    automatically determined based on array size of the clock table
> 
> Changes from v1:
>  - Separate drivers/clk/Makefile change for drivers/clk/bcm out to a standalone patch

FWIW I tested this series on BCM958305K SVK.

Tested-by: Dmitry Torokhov <dtor@chromium.org>

Thanks.

-- 
Dmitry
