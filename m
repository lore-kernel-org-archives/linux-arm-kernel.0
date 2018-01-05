From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jan 2018 11:22:03 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.16, step 2
Message-ID: <20180105102203.braqydzlkoy5tk3v@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Happy new year :)

Here is the second bunch of changes we talked about in our first PR.

There's one fix for 4.16, and the other patches have been around for
quite a while that I'm feeling confident that we should merge them.

On a side note, my GPG key changed recently. The new fingerprint is
2BA0E943D27E3D2094B10B24D824ECA89C346DCE, and you'll find that it has
been signed by a bunch of kernel developpers already. The old one is
superseeded, but has not been compromised.

Thanks!
Maxime

The following changes since commit 2ce3dc66d75fc204cc42bc4ee9c6f612ef4a8949:

  ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet 0 in aliases (2017-12-19 09:54:46 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.16-2

for you to fetch changes up to 1ce799079155cab76ccc521b9cf870c2cb9aa96c:

  ARM: dts: sun8i: a711: Enable the LCD (2018-01-05 09:54:34 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.16, bis

A few improvements to our DT support, with:
  - basic DRM support for the A83t
  - simplefb support for the H3 and H5 SoCs
  - One fix for the USB ethernet on the Orange Pi R1

----------------------------------------------------------------
Icenowy Zheng (5):
      ARM: dts: sun8i: fix USB Ethernet of Orange Pi R1
      dt-bindings: simplefb-sunxi: add pipelines for DE2
      ARM: sun8i: h3/h5: add DE2 CCU device node for H3
      arm64: allwinner: h5: add compatible string for DE2 CCU
      ARM: sunxi: h3/h5: add simplefb nodes

Maxime Ripard (4):
      ARM: dts: sun8i: a83t: Add display pipeline
      ARM: dts: sun8i: a83t: Enable the PWM
      ARM: dts: sun8i: a83t: Add LVDS pins group
      ARM: dts: sun8i: a711: Enable the LCD

 .../bindings/display/simple-framebuffer-sunxi.txt  |  4 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 61 +++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 99 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts    | 18 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 38 +++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |  4 +
 7 files changed, 228 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180105/09c260c1/attachment.sig>
