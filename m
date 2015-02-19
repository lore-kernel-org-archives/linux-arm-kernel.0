From: rk@ti.com (Ravikumar Kattekola)
Date: Thu, 19 Feb 2015 20:38:29 +0530
Subject: [PATCH 0/2] ARM: DRA7x/OMAP5: Clock: DPLL Clock fixes
In-Reply-To: <1422724005-9415-1-git-send-email-rk@ti.com>
References: <1422724005-9415-1-git-send-email-rk@ti.com>
Message-ID: <54E5FC6D.7040701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2015 10:36 PM, Ravikumar Kattekola wrote:
> Fix bypass clock source for a few DPLLs.
>
> On DRA7x/OMAP5, for a few DPLLs, both CLKINP and CLKINPULOW are connected
> to a mux and the output from mux is routed to the bypass clkout.
> Add a mux-clock as bypass clock with CLKINP and CLKINPULOW as parents.
>
> Tested against:
> 	tree: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> 	branch: master
> On:
> CPU  : OMAP5432 ES2.0
> Board: OMAP5432 uEVM
> and
> CPU  : DRA752 ES1.0
> Board: DRA7xx
>
>
> Ravikumar Kattekola (2):
>    ARM: DRA7x: dts: Fix the bypass clock source for dpll_iva and others
>    ARM: OMAP5: dts: Fix the bypass clock source for dpll_iva and others
>
>   arch/arm/boot/dts/dra7xx-clocks.dtsi   |   90 ++++++++++++++++++++++++++++----
>   arch/arm/boot/dts/omap54xx-clocks.dtsi |   41 +++++++++++++--
>   2 files changed, 118 insertions(+), 13 deletions(-)
>
Hi Benoit,
     Can these fixes be looked into for 3.20-rc?

Regards,
RK
