From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Jan 2014 00:10:33 +0100
Subject: [GIT PULL] Allwinner DT changes for 3.14, take 2
Message-ID: <20140107231033.GA18548@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes on top of the previous pull request.

Thanks!
Maxime

The following changes since commit 81ee429ffdd021626bf191bb8a3ae886dd94adcc:

  ARM: sun6i: dt: Add IP needed to bring up the additional cores (2013-12-16 21:15:12 +0100)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.14-2

for you to fetch changes up to 6267355f0e513bed9a5009924abc7a1e7de22ab3:

  arm: sun7i: cubietruck: Enable the i2c controllers (2014-01-07 23:39:19 +0100)

----------------------------------------------------------------
Second round of DT additions for 3.14

Mostly:
  - Addition of the missing PLLs and module clocks
  - Addition of the external clocks
  - Addition of the touchscreen controler
  - I2C nodes of the Cubietruck

----------------------------------------------------------------
Chen-Yu Tsai (4):
      ARM: dts: sun7i: Add pin muxing options for clock outputs
      ARM: dts: sun7i: Change 32768 Hz oscillator node name to clk at N style
      ARM: dts: sun7i: external clock outputs
      arm: sun7i: cubietruck: Enable the i2c controllers

Emilio L?pez (6):
      ARM: sunxi: add PLL4 support
      ARM: sunxi: add PLL5 and PLL6 support
      ARM: sun4i: dt: mod0 clocks
      ARM: sun5i: dt: mod0 clocks
      ARM: sun7i: dt: mod0 clocks
      ARM: sunxi: dt: add nodes for the mbus clock

Hans de Goede (3):
      ARM: dts: sun4i: Add rtp controller node
      ARM: dts: sun5i: Add rtp controller node
      ARM: dts: sun7i: Add rtp controller node

Maxime Ripard (3):
      Merge tag 'sunxi-clk-3.14-for-maxime' of https://bitbucket.org/emiliolopez/linux into sunxi/dt-for-3.14
      ARM: sun4i: dt: Move the aliases to the DTSI
      ARM: sun4i: dt: Remove chosen nodes

 arch/arm/boot/dts/sun4i-a10-a1000.dts      |   4 -
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts |   9 --
 arch/arm/boot/dts/sun4i-a10-hackberry.dts  |   4 -
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts |   4 -
 arch/arm/boot/dts/sun4i-a10.dtsi           | 154 ++++++++++++++++++++-
 arch/arm/boot/dts/sun5i-a10s.dtsi          | 128 ++++++++++++++++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts  |   4 -
 arch/arm/boot/dts/sun5i-a13.dtsi           | 128 ++++++++++++++++-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts |  18 +++
 arch/arm/boot/dts/sun7i-a20.dtsi           | 212 +++++++++++++++++++++++++++--
 10 files changed, 622 insertions(+), 43 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/a07bd353/attachment.sig>
