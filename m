From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 1 Oct 2014 13:58:07 +0200
Subject: [GIT PULL] ARM: STi: DT changes for v3.18
In-Reply-To: <54215982.2040909@st.com>
References: <54215982.2040909@st.com>
Message-ID: <542BEC4F.9080207@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

	This is a gentle reminder for this pull request I sent early last week.

	I hope it is not too late for the merge window?

Thanks,
Maxime

On 09/23/2014 01:29 PM, Maxime Coquelin wrote:
> Hi Olof, Kevin and Arnd,
> 
> Please consider these STi DT updates for v3.18.
> This pull request contains a merge from Philipp Zabel's reset tag that will not be rebased.
> (See https://lkml.org/lkml/2014/9/9/856)
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>    Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>    git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.18-1
> 
> for you to fetch changes up to 487eebe358ab131ccb20280bb75ea14c02751c2d:
> 
>    ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing (2014-09-23 09:46:11 +0200)
> 
> ----------------------------------------------------------------
> STi DT uptades for v3.18.
> 
> Highlights:
> -----------
>   - Add SDHCI support for STiH41x B2020 boards
>   - Add reset controllers to STiH407 SoC
>   - Add MiPHY & SATA support to STiH416
>   - Add Thermal supportto STiH416
>   - Add Clock support to STiH407 SoC
> 
> Note that this pull request contains merge from Philipp Zabel's reset tree for STiH407 reset DT bindings includes.
> 
> ----------------------------------------------------------------
> Gabriel FERNANDEZ (6):
>        ARM: STi: DT: STiH407: 407 DT Entry for clockgen A0
>        ARM: STi: DT: STiH407: 407 DT Entry for clockgen C0
>        ARM: STi: DT: STiH407: 407 DT Entry for clockgen D0/D2/D3
>        ARM: STi: DT: STiH407: 407 DT Entry for clockgenA9
>        ARM: STi: DT: STiH407: Add all defines for STiH407 DT clocks
>        ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing
> 
> Lee Jones (4):
>        ARM: STi: DT: STiH41x: Convert all uppercase non-defines to lowercase
>        ARM: STi: DT: STiH416: Supply Thermal Controller Device Tree nodes
>        ARM: DT: STi: STiH416: Add DT node for MiPHY365x
>        ARM: DT: STi: STiH416: Add DT node for ST's SATA device
> 
> Maxime Coquelin (1):
>        Merge tag 'reset-for-sti-3.18' from git://git.pengutronix.de/git/pza/linux.git into sti-dt-for-v3.18
> 
> Peter Griffin (10):
>        reset: stih407: Add softreset, powerdown and picophy controllers
>        reset: sti: Document sti-picophyreset controllers bindings.
>        ARM: sti: Add STiH407 Kconfig entry to select STIH407_RESET
>        ARM: sti: Add STiH407 reset controller support.
>        ARM: STi: DT: Add sdhci pins for stih416
>        ARM: STi: DT: Add sdhci controller for stih416
>        ARM: STi: DT: Add sdhci pin configuration for stih415
>        ARM: STi: DT: Add sdhci controller for stih415
>        ARM: STi: DT: Enable mmc0 for both stih415 and stih416 SoCs
>        ARM: STi: DT: Enable second sdhci controller for stih416 b2020 boards.
> 
>   .../bindings/reset/st,sti-picophyreset.txt         |  42 +++
>   arch/arm/boot/dts/stih407-clock.dtsi               | 293 +++++++++++++++-
>   arch/arm/boot/dts/stih407.dtsi                     |  34 +-
>   arch/arm/boot/dts/stih415-pinctrl.dtsi             | 361 ++++++++++---------
>   arch/arm/boot/dts/stih415.dtsi                     |  12 +
>   arch/arm/boot/dts/stih416-b2020.dts                |  22 ++
>   arch/arm/boot/dts/stih416-b2020e.dts               |  26 +-
>   arch/arm/boot/dts/stih416-pinctrl.dtsi             | 381 ++++++++++++---------
>   arch/arm/boot/dts/stih416.dtsi                     |  80 +++++
>   arch/arm/boot/dts/stih41x-b2000.dtsi               |   6 +-
>   arch/arm/boot/dts/stih41x-b2020.dtsi               |  10 +-
>   arch/arm/boot/dts/stih41x-b2020x.dtsi              |   4 +
>   arch/arm/mach-sti/Kconfig                          |  10 +
>   drivers/reset/sti/Kconfig                          |   4 +
>   drivers/reset/sti/Makefile                         |   1 +
>   drivers/reset/sti/reset-stih407.c                  | 158 +++++++++
>   include/dt-bindings/clock/stih407-clks.h           |  86 +++++
>   .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++
>   18 files changed, 1229 insertions(+), 362 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
>   create mode 100644 drivers/reset/sti/reset-stih407.c
>   create mode 100644 include/dt-bindings/clock/stih407-clks.h
>   create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
> 
