From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Wed, 18 Jul 2012 10:59:11 +0530
Subject: [GIT PULL] SPEAr platform fixes over 3.5-rc7
In-Reply-To: <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
References: <20120717130150.GM1994@localhost.localdomain>
 <CAOesGMgHFrydxO-eJiuTL2yLKmVZXMcqiPhnBZQgbd=YcXD-Mg@mail.gmail.com>
Message-ID: <20120718052911.GQ1994@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jul 17, 2012 at 08:43:34PM -0700, Olof Johansson wrote:
> Hi Shiraz,
> 
> I see that every commit in that branch is done by you, but not a
> single one has a Signed-off-by by you. Please fix that, it's important
> to track the history of how code is introduced to the kernel.
> 
> Also, we are _very_ late in the 3.5 release cycle now. Only truly
> critical fixes can go in (3.5 is likely to come out by the weekend). I
> have some comments about the patches below.
> 
> In general, to make our life easier, please make sure the commit
> message for the patch describes why the fix is needed when it's not
> obvious.
> 
> I'll wait with pulling until you have a chance to fix up your branch
> based on the below comments. Please make sure you do it with extreme
> expediency though, or chances are it'll miss 3.5.

I have tried to fix all points mentioned by you and updated the spear
fixes branch.

The following changes since commit 84a1caf1453c3d44050bd22db958af4a7f99315c:

  Linux 3.5-rc7 (2012-07-14 15:40:28 -0700)

are available in the git repository at:

  http://git.stlinux.com/spear/linux-2.6.git for-3.5-spear-fixes

for you to fetch changes up to 69c7e3772eaee5d2097725cdb79bc3ef867c0d9e:

  ARM: SPEAr600: Fix timer interrupt definition in spear600.dtsi (2012-07-18 10:05:05 +0530)

----------------------------------------------------------------
Stefan Roese (1):
      ARM: SPEAr600: Fix timer interrupt definition in spear600.dtsi

Vipul Kumar Samar (9):
      clk:spear1340:Fix: Rename clk ids within predefined limit
      clk:spear1310:Fix: Rename clk ids within predefined limit
      Clk:spear3xx:Fix: Rename clk ids within predefined limit
      Clk:spear6xx:Fix: Rename clk ids within predefined limit
      ARM: SPEAr13xx: Fix Interrupt bindings
      clk: SPEAr1340: Fix clk enable register for uart1 and i2c1.
      Clk: SPEAr1340: Update sys clock parent array
      ARM: dts: SPEAr320: Fix compatible string
      ARM: dts: SPEAr320: Boot the board in EXTENDED_MODE

 arch/arm/boot/dts/spear13xx.dtsi    |   11 +-
 arch/arm/boot/dts/spear320-evb.dts  |    6 +-
 arch/arm/boot/dts/spear600.dtsi     |    1 +
 arch/arm/mach-spear3xx/spear3xx.c   |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c   |    2 +-
 drivers/clk/spear/spear1310_clock.c |  312 +++++++++++++++++------------------
 drivers/clk/spear/spear1340_clock.c |  279 ++++++++++++++++---------------
 drivers/clk/spear/spear3xx_clock.c  |  180 ++++++++++----------
 drivers/clk/spear/spear6xx_clock.c  |  122 +++++++-------
 9 files changed, 451 insertions(+), 464 deletions(-)

--
regards
Shiraz
