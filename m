From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 11:51:57 +0800
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <20120426081637.GD17184@pengutronix.de>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
 <20120426081637.GD17184@pengutronix.de>
Message-ID: <20120427035155.GF2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:16:37AM +0200, Sascha Hauer wrote:
> On Tue, Apr 24, 2012 at 08:35:36PM -0300, Fabio Estevam wrote:
> > mx6qsabrelite has a sst25vf016b SPI NOR flash connected to eCSPI1.
> > 
> > Add support for it.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Shawn, are you ok with this? If yes I would take this into my queue
> 
Then please take the pull request below. It contains my collecting of
imx dts changes.

Regards,
Shawn

---

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt

Fabio Estevam (3):
      ARM: dts: imx: Remove bootargs field
      ARM: imx6q-arm2: Remove hardcoded mac address
      ARM: dts: Add basic support for imx6q-sabresd

Shawn Guo (1):
      ARM: imx: rename uart and fec device tree nodes

Ying-Chun Liu (PaulLiu) (1):
      ARM: dts: imx6q: add anatop regulators

 Documentation/devicetree/bindings/arm/fsl.txt      |    4 +
 Documentation/devicetree/bindings/net/fsl-fec.txt  |    2 +-
 .../bindings/tty/serial/fsl-imx-uart.txt           |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycore.dts         |    8 +-
 arch/arm/boot/dts/imx27.dtsi                       |   14 ++--
 arch/arm/boot/dts/imx51-babbage.dts                |   12 +--
 arch/arm/boot/dts/imx51.dtsi                       |    8 +-
 arch/arm/boot/dts/imx53-ard.dts                    |    6 +-
 arch/arm/boot/dts/imx53-evk.dts                    |    8 +--
 arch/arm/boot/dts/imx53-qsb.dts                    |    8 +--
 arch/arm/boot/dts/imx53-smd.dts                    |   12 +--
 arch/arm/boot/dts/imx53.dtsi                       |   12 ++--
 arch/arm/boot/dts/imx6q-arm2.dts                   |    9 +--
 arch/arm/boot/dts/imx6q-sabrelite.dts              |    4 +-
 arch/arm/boot/dts/imx6q-sabresd.dts                |   53 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |   96 ++++++++++++++++++--
 arch/arm/mach-imx/Makefile.boot                    |    3 +-
 arch/arm/mach-imx/clock-imx6q.c                    |   12 ++--
 arch/arm/mach-imx/mach-imx6q.c                     |    1 +
 19 files changed, 196 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabresd.dts
