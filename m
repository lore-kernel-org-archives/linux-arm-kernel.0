From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Fri, 25 Apr 2014 11:23:23 +0530
Subject: [PATCH v3 00/16] exynos5420: clock file cleanup
In-Reply-To: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <CAOD6ATq1FO_gKPU6jNWR_tBfoO5h4WECPp--pe8XZjWnJeMiOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 6:33 PM, Shaik Ameer Basha
<shaik.ameer@samsung.com> wrote:
> Many changes/fixes have been identified for clock file for exynos5420.
> These include correct parents, bit fields, new clocks etc. Existing
> files needs some correction in terms of names of the clock and
> indentation. These issues are addressed in this patch series. It also
> replaces the usage of enums with macro as clock ids.
>
> This patch series is rebased on,
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git:master
>
> This patch is also dependent on the following patch.
> ARM: dts: add dt node for sss module for exynos5250/5420

Sorry, it depends on SSS clock patch. Not the dts one.
clk: samsung exynos5250/5420: Add gate clock for SSS module

>
> Changes since v2:
> -----------------
> 1] Addressed review comments from Gerhard Sittig and Tomasz Figa.
>
> Changes since v1:
> -----------------
> 1] Addressed review comments from Tomasz Figa.
>     http://www.spinics.net/lists/devicetree/msg16759.html
>     http://www.spinics.net/lists/devicetree/msg16760.html
>
> Shaik Ameer Basha (16):
>   clk: exynos5420: rename parent clocks
>   clk: exynos5420: add clocks for ISP block
>   clk: exynos5420: update clocks for GSCL and MSCL blocks
>   clk: exynos5420: correct clock parents for mscl sysmmu
>   clk: exynos5420: update clocks for G2D block
>   clk: exynos5420: update clocks for DISP1 block
>   clk: exynos5420: update clocks for PERIC block
>   clk: exynos5420: update clocks for PERIS and GEN blocks
>   clk: exynos5420: update clocks for WCORE block
>   clk: exynos5420: update clocks for FSYS and FSYS2 blocks
>   clk: exynos5420: correct sysmmu-mfc parent clocks
>   clk: exynos5420: fix register offset for sclk_bpll
>   clk: exynos5420: cleanup core and misc clocks
>   clk: exynos5420: correct g3d parent clock
>   clk: exynos5420: create clock ID for mout_sclk_vpll
>   clk: exynos5420: add more registers to restore list
>
>  arch/arm/boot/dts/exynos5420.dtsi      |   14 +-
>  drivers/clk/samsung/clk-exynos5420.c   |  808 ++++++++++++++++++++------------
>  include/dt-bindings/clock/exynos5420.h |   33 +-
>  3 files changed, 550 insertions(+), 305 deletions(-)
>  mode change 100644 => 100755 drivers/clk/samsung/clk-exynos5420.c
>  mode change 100644 => 100755 include/dt-bindings/clock/exynos5420.h
>
> --
> 1.7.9.5
>
