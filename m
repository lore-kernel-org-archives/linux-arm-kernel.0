From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 11:20:54 +0800
Subject: [PATCH 1/3] ARM: dts: imx7d: create i.MX 7Solo base device tree
In-Reply-To: <9d870fb1be40772a50f08d467df048dc@agner.ch>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-2-stefan@agner.ch>
 <20160612013526.GV20243@tiger>
 <9d870fb1be40772a50f08d467df048dc@agner.ch>
Message-ID: <20160621032053.GB21364@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2016 at 09:20:05PM -0700, Stefan Agner wrote:
> On 2016-06-11 18:35, Shawn Guo wrote:
> > On Tue, Jun 07, 2016 at 07:37:07PM -0700, Stefan Agner wrote:
> >> The i.MX 7 series currently consists of two SoCs: i.MX 7Solo and
> >> 7Dual. The i.MX 7Solo implements a subset of features available on
> >> i.MX 7Dual, hence create imx7s.dtsi as the base device tree. The
> >> i.MX 7Dual's additional features over i.MX 7Solo are:
> >> - Second Cortex-A7 core
> >> - Second Gigabit Ethernet controller
> >> - EPD (Electronc Paper Display, not yet part of the device tree)
> >> - PCIe (not yet part of the device tree)
> >> - Additional USB2.0 OTG controller
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  arch/arm/boot/dts/imx7d.dtsi | 923 +++----------------------------------------
> >>  arch/arm/boot/dts/imx7s.dtsi | 880 +++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 928 insertions(+), 875 deletions(-)
> > 
> > We should probably have a beforehand patch to rename the file, so that
> > we can avoid this dramatic diffstat.
> 
> If I delete imx7d.dtsi and add imx7s.dtsi in a single commit, and then
> readd imx7d.dtsi in a second commit, it would break bisect-ability. All
> existing device trees which include imx7d.dtsi would fail to build.

I was thinking that we would patch imx7d.dtsi users to include
imx7s.dtsi in the first patch that does renaming, and then patch them
back in the second patch that adds imx7d.dtsi.  It sounds a bit silly,
but it really helps to make the history clear and diffstats nice.  It
looks like something below.

commit 49669c3630183bb1a36fcaf4bef324a7d839a5fd
Date:   Tue Jun 21 11:13:02 2016 +0800

    add imx7d.dtsi and patch users back

 arch/arm/boot/dts/imx7d-cl-som-imx7.dts |  2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts   |  2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         |  2 +-
 arch/arm/boot/dts/imx7d.dtsi            | 11 +++++++++++
 arch/arm/boot/dts/imx7s.dtsi            |  6 ------
 5 files changed, 14 insertions(+), 9 deletions(-)

commit 7e1c82e1aee3d6e694901cea3dd74e9b4ec6643e
Date:   Tue Jun 21 11:04:02 2016 +0800

    rename imx7d.dtsi to imx7s.dtsi

 arch/arm/boot/dts/imx7d-cl-som-imx7.dts      | 2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts        | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts              | 2 +-
 arch/arm/boot/dts/{imx7d.dtsi => imx7s.dtsi} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)

Shawn
