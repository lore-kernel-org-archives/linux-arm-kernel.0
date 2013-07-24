From: horms@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 17:06:01 +0900
Subject: [GIT 00/16] Renesas ARM based SoC updates for v3.12
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
Message-ID: <20130724080600.GB9276@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 09:33:45AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following Renesas ARM based SoC updates for v3.12.
> 
> This pull request is based on renesas-dt-for-v3.12 which I have
> previously sent a pull request for.

This pull request has conflicts with renesas-pinmux-for-v3.12, which I also
sent a pull request for earlier today. I have a provided an example
resolution as part of the renesas-devel-20130724v2 tag in the renesas tree.

In words: take both sides.

The conflicting files are:
        arch/arm/boot/dts/r8a73a4.dtsi
        arch/arm/boot/dts/r8a7790.dtsi

> 
> The following changes since commit 66a5cab04d339d02b93a4671eadf8e251dbfdc2c:
> 
>   ARM: shmobile: Add SMSC ethernet chip to KZM9D DT reference (2013-07-17 10:06:47 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.12
> 
> for you to fetch changes up to 81b9d5351fa96caad4accc6711bc1b9342927d4a:
> 
>   ARM: shmobile: Setup r8a7790 arch timer based on MD pins (2013-07-17 14:26:56 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC updates for v3.12
> 
> * Setup arch timer based on MD pins on r8a7790 SoC
> * Thermal driver support for r8a7790 SoC
> * Make arch timer optional for r8a7790 and r8a73a4 SoCs
> * CMT10 clock event for r8a7790 and r8a73a4 SoCs
> * Increased clock coverage for r8a73a4 SoC
> * MMCIF DMA definitions for r8a7740 SoC
> * Disconnect SMP code from clocks on emev2 SoC
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (6):
>       ARM: shmobile: r8a73a4: wait for completion when kicking the clock
>       ARM: shmobile: r8a73a4: implement CPU clock scaling for CPUFreq
>       ARM: shmobile: r8a73a4: safeguard against wrong clk_set_rate() uses
>       ARM: shmobile: r8a73a4: add Z2 clock support
>       ARM: shmobile: r8a73a4: add clocks for I2C controllers
>       ARM: shmobile: r8a7740: add MMCIF DMA definitions
> 
> Magnus Damm (8):
>       ARM: shmobile: Sort r8a7790 MSTP entries
>       ARM: shmobile: Add r8a7790 CMT00 clock event
>       ARM: shmobile: Make r8a7790 Arch timer optional
>       ARM: shmobile: Add r8a73a4 CMT10 clock event
>       ARM: shmobile: Make r8a73a4 Arch timer optional
>       ARM: shmobile: Disconnect EMEV2 SMP code from clocks
>       ARM: shmobile: Introduce r8a7790_read_mode_pins()
>       ARM: shmobile: Setup r8a7790 arch timer based on MD pins
> 
> Simon Horman (2):
>       ARM: shmobile: r8a7790: add clocks for thermal
>       ARM: shmobile: r8a7790: add thermal driver support
> 
>  arch/arm/mach-shmobile/Kconfig                |   4 +-
>  arch/arm/mach-shmobile/board-ape6evm.c        |   1 +
>  arch/arm/mach-shmobile/board-lager.c          |   1 +
>  arch/arm/mach-shmobile/clock-emev2.c          |  18 ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c        | 199 ++++++++++++++++++++++++--
>  arch/arm/mach-shmobile/clock-r8a7790.c        |  23 +--
>  arch/arm/mach-shmobile/include/mach/emev2.h   |   1 -
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |   1 +
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |   2 +
>  arch/arm/mach-shmobile/include/mach/r8a7790.h |   4 +
>  arch/arm/mach-shmobile/setup-r8a73a4.c        |  30 ++++
>  arch/arm/mach-shmobile/setup-r8a7740.c        |  10 ++
>  arch/arm/mach-shmobile/setup-r8a7790.c        | 106 +++++++++++++-
>  arch/arm/mach-shmobile/smp-emev2.c            |  11 +-
>  14 files changed, 363 insertions(+), 48 deletions(-)
> 
