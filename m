From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 22 May 2013 12:07:30 +0200
Subject: [v2 0/6] CLK: tegra: convert device tree files to use CLK defines
In-Reply-To: <20130522091248.b3acd9c56ab66535d75b8fd1@nvidia.com>
References: <1369127450-15203-1-git-send-email-hdoyu@nvidia.com><519B9B5D.4050402@wwwdotorg.org><20130522091248.b3acd9c56ab66535d75b8fd1@nvidia.com>
Message-ID: <20130522.130730.1153046210420942555.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiroshi Doyu <hdoyu@nvidia.com> wrote @ Wed, 22 May 2013 08:12:48 +0200:

> On Tue, 21 May 2013 18:05:49 +0200
> Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > On 05/21/2013 03:10 AM, Hiroshi Doyu wrote:
> > > This patchset converts device tree files to use CLK defines. This
> > > version was updated along with the latest DT changes.
> > > 
> > > The following changes since commit 7479d8bb5650f43053d0e82fa44db668cf968f11:
> > > 
> > >   TESTING: Build Tegra USB as a module (2013-05-20 13:11:19 -0600)
> > 
> > That commit is in my personal work-in-progress branch. This series
> > should be based on Tegra's for-3.11/dt branch. This will make a
> > difference (at least) in patch 6/6, where you've edited some DT nodes
> > that don't yet exist upstream (i.e. Tegra's for-3.11/dt branch) and
> > hence this series won't apply there.
> 
> I'll rebase.

Rebased on Tegra's for-3.11/dt, including fix: [2/6] over 80 columns.

If you want me to send patches again, please let me know.

The following changes since commit 4d0c81c723f78a2f7f6ef844ff8e1fd174180029:

  ARM: tegra: Add charger subnode to tps65090 node (2013-05-20 13:14:09 -0600)

are available in the git repository at:

  git://nv-tegra.nvidia.com/user/hdoyu/linux.git dt-replace-clkid3

for you to fetch changes up to 00535ac4b17af0691a73737a70b0cbd78a9d2262:

  ARM: tegra114: convert device tree files to use CLK defines (2013-05-22 12:58:04 +0300)

----------------------------------------------------------------
Hiroshi Doyu (6):
      ARM: tegra20: create a DT header defining CLK IDs
      ARM: tegra20: convert device tree files to use CLK defines
      ARM: tegra30: create a DT header defining CLK IDs
      ARM: tegra30: convert device tree files to use CLK defines
      ARM: tegra114: create a DT header defining CLK IDs
      ARM: tegra114: convert device tree files to use CLK defines

 .../bindings/clock/nvidia,tegra114-car.txt         | 252 +--------------
 .../bindings/clock/nvidia,tegra20-car.txt          | 154 +---------
 .../bindings/clock/nvidia,tegra30-car.txt          | 211 +------------
 arch/arm/boot/dts/tegra114.dtsi                    |  51 +--
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |   4 +-
 arch/arm/boot/dts/tegra20-medcom-wide.dts          |   4 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |   7 +-
 arch/arm/boot/dts/tegra20-plutux.dts               |   4 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |   4 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |   4 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   4 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |   4 +-
 arch/arm/boot/dts/tegra20-whistler.dts             |   4 +-
 arch/arm/boot/dts/tegra20.dtsi                     | 116 +++----
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   4 +-
 arch/arm/boot/dts/tegra30.dtsi                     | 110 ++++---
 include/dt-bindings/clk/tegra114-car.h             | 342 +++++++++++++++++++++
 include/dt-bindings/clk/tegra20-car.h              | 158 ++++++++++
 include/dt-bindings/clk/tegra30-car.h              | 265 ++++++++++++++++
 20 files changed, 963 insertions(+), 743 deletions(-)
 create mode 100644 include/dt-bindings/clk/tegra114-car.h
 create mode 100644 include/dt-bindings/clk/tegra20-car.h
 create mode 100644 include/dt-bindings/clk/tegra30-car.h
