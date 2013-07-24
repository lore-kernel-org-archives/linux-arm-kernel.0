From: horms@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 17:05:32 +0900
Subject: [GIT 00/19 v2] Renesas ARM based SoC pinmux updates for v3.12
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <20130724080532.GA9276@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 09:32:14AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following pinmux updates for v3.12.
> 
> Difference with v1 of this pull-request:
> * Remove bogus i2c portions of the first patch of the series.
> * Correct addressing mode used in dts of the first patch of the series.
> * Removal of egg from face: wip

This pull request has conflicts with renesas-soc-for-v3.12, which I also
sent a pull request for earlier today. I have a provided an example
resolution as part of the renesas-devel-20130724v2 tag in the renesas tree.

In words: take both sides.

The conflicting files are:
	arch/arm/boot/dts/r8a73a4.dtsi
	arch/arm/boot/dts/r8a7790.dtsi

> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.12
> 
> for you to fetch changes up to 1469273960de45275f33276c7254456edcba9da2:
> 
>   ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree (2013-07-22 10:12:41 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC pinmux updates for v3.12
> 
> SH Mobile pinctrl DT support
> 
> ----------------------------------------------------------------
> Laurent Pinchart (19):
>       ARM: shmobile: r8a73a4: Add pin control device to device tree
>       ARM: shmobile: r8a7740: Add pin control device to device tree
>       ARM: shmobile: r8a7778: Add pin control device to device tree
>       ARM: shmobile: r8a7778: Add GPIO controller devices to device tree
>       ARM: shmobile: r8a7779: Add pin control device to device tree
>       ARM: shmobile: r8a7779: Add GPIO controller devices to device tree
>       ARM: shmobile: r8a7790: Add pin control device to device tree
>       ARM: shmobile: r8a7790: Add GPIO controller devices to device tree
>       ARM: shmobile: sh7372: Add pin control device to device tree
>       ARM: shmobile: sh73a0: Add pin control device to device tree
>       ARM: shmobile: armadillo-reference: Move pinctrl mappings to device tree
>       ARM: shmobile: armadillo-reference: Add st1232 pin mappings
>       ARM: shmobile: armadillo-reference: Move st1232 reset GPIO to DT
>       ARM: shmobile: armadillo-reference: Add LED1-LED4 to the device tree
>       ARM: shmobile: marzen-reference: Move pinctrl mappings to device tree
>       ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree
>       ARM: shmobile: kzm9g-reference: Move pinctrl mappings to device tree
>       ARM: shmobile: kzm9g-reference: Move SDHI regulators to DT
>       ARM: shmobile: kzm9g-reference: Add LED1-LED4 to the device tree
> 
>  arch/arm/boot/dts/r8a73a4.dtsi                     |  7 ++
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts | 34 ++++++++
>  arch/arm/boot/dts/r8a7740.dtsi                     |  8 ++
>  arch/arm/boot/dts/r8a7778.dtsi                     | 66 ++++++++++++++++
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts     | 49 ++++++++++++
>  arch/arm/boot/dts/r8a7779.dtsi                     | 90 ++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi                     | 78 +++++++++++++++++++
>  arch/arm/boot/dts/sh7372.dtsi                      |  8 ++
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 90 +++++++++++++++++++++-
>  arch/arm/boot/dts/sh73a0.dtsi                      |  8 ++
>  .../board-armadillo800eva-reference.c              | 18 +----
>  arch/arm/mach-shmobile/board-kzm9g-reference.c     | 47 -----------
>  arch/arm/mach-shmobile/board-marzen-reference.c    | 28 -------
>  13 files changed, 437 insertions(+), 94 deletions(-)
> 
