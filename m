From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 13 Aug 2013 16:27:10 -0700
Subject: arm-soc: Xilinx Zynq cleanups for v3.12
In-Reply-To: <520A47C7.4050000@monstr.eu> (Michal Simek's message of "Tue, 13
 Aug 2013 16:50:47 +0200")
References: <520A47C7.4050000@monstr.eu>
Message-ID: <87y585dve9.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mike Turquette

Michal Simek <monstr@monstr.eu> writes:

> Hi Arnd and Olof,

I'm helping out with arm-soc maintenance now too and I'm on the
arm at kernel.org alias, thanks for Cc'ing it.

> please pull these cleanup patches to your tree.
>
> Thanks,
> Michal
>
> The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>
>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>
> are available in the git repository at:
>
>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.12
>
> for you to fetch changes up to 060968ff9fa1a56b22cc2454906a233d302b1bd2:
>
>   arm: zynq: hotplug: Remove unreachable code (2013-08-13 16:09:12 +0200)
>
> ----------------------------------------------------------------
> arm: Xilinx Zynq cleanup patches for v3.12
>
> This branch contains these fixes:
> - SLCR cleanup
> - 2 minor zynq pll fixes
> - Hotplug cleanup
>
> ----------------------------------------------------------------
> Soren Brinkmann (6):
>       arm: zynq: slcr: Remove redundant header #includes
>       arm: zynq: slcr: Clean up #defines
>       arm: zynq: slcr: Use read-modify-write for register writes
>       clk/zynq/pll: Fix documentation for PLL register function
>       clk/zynq/pll: Use #defines for fbdiv min/max values

These drivers/clk changes should go through the clock maintainer Mike
Turquette.  Could you split them out into a separate pull request?

Alternatively, if Mike is confident there won't be any conflicts with
his tree, I'll happily merge them through arm-soc with his ack.

Otherwise, the rest of the stuff looks OK for v3.12 cleanups and I can
apply it when the path of the clock changes is cleared up.

Thanks,

Kevin

>       arm: zynq: hotplug: Remove unreachable code
>
>  arch/arm/mach-zynq/hotplug.c | 55 +++++--------------------------------------------------
>  arch/arm/mach-zynq/slcr.c    | 45 +++++++++++++++++----------------------------
>  drivers/clk/zynq/pll.c       | 18 +++++++++++++-----
>  3 files changed, 35 insertions(+), 83 deletions(-)
