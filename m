From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:39:14 +0100
Subject: [GIT PULL] Allwinner fixes for 3.19
Message-ID: <20150125173914.GA26866@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following commits for the 3.19 kernel.

Thanks!
Maxime

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-3.19

for you to fetch changes up to 117a2cc38ffe0b46bcc6f991a3534b345477439c:

  ARM: sunxi: dt: Fix aliases (2015-01-25 18:06:34 +0100)

----------------------------------------------------------------
Allwinner fixes for 3.19

A few minor fixes for the 3.19 kernel:
  - The 8250 uart driver now respects the aliases, which pointed out that we
    were using them wrong. Fixed them.
  - The simplefb pipeline that was used on the A10 caused flickering and
    tearing, and rendered it pretty much useless. Added a new simplefb node
    with another pipeline that removes this issue. Note that we need to keep
    the old node because u-boot 2015.01 uses it.
  - Added a fix for the USB phy node on sun4i/sun5i

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sunxi: Fix usb-phy support for sun4i/sun5i

Hans de Goede (2):
      ARM: dts: sun6i: ippo-q8h-v5: Fix serial0 alias
      ARM: dts: sun4i: Add simplefb node with de_fe0-de_be0-lcd0-hdmi pipeline

Maxime Ripard (1):
      ARM: sunxi: dt: Fix aliases

 arch/arm/boot/dts/sun4i-a10.dtsi                 | 20 ++++++++++----------
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  6 ++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  8 ++------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  4 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  4 ++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  9 ++-------
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  6 ------
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  8 ++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  3 +++
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  8 --------
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  4 ++++
 arch/arm/boot/dts/sun8i-a23.dtsi                 |  9 ---------
 arch/arm/boot/dts/sun9i-a80-optimus.dts          |  5 +++++
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 10 ----------
 16 files changed, 58 insertions(+), 56 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/e8c5d748/attachment.sig>
