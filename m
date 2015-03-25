From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 14:19:11 -0700
Subject: [GIT PULL] Allwinner clocks additions for 4.1
Message-ID: <20150325211911.GA17639@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Here is the pull request for the Allwinner related changes for the 4.1
merge window.

Thanks!
Maxime

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-4.1

for you to fetch changes up to f1017969661dd33ead5ba7c3f4a0793c6611441a:

  clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6 (2015-03-25 11:46:41 -0700)

----------------------------------------------------------------
Allwinner clocks changes for 4.1

The usual round of clock changes for the Allwinner SoCs.

There is nothing really standing out here, but a few changes and fixes, most
notably to allow the AHB clock to be parented to a PLL, instead of the CPU
clock to avoid any AHB rate change due to cpufreq.

----------------------------------------------------------------
Chen-Yu Tsai (7):
      clk: sunxi: Move USB clocks to separate file
      clk: sunxi: Add support for sun9i A80 USB clocks and resets
      clk: sunxi: Add muxable ahb factors clock for sun5i and sun7i
      clk: sunxi: Add "cpu" to list of protected clocks for sun5i
      clk: sunxi: Register divs clocks before factor clocks
      clk: sunxi: Make divs clocks specify which output is the base factor clock
      clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6

 Documentation/devicetree/bindings/clock/sunxi.txt |   3 +
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 185 ++++++++---------
 drivers/clk/sunxi/clk-usb.c                       | 233 ++++++++++++++++++++++
 4 files changed, 319 insertions(+), 103 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-usb.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/a7821616/attachment-0001.sig>
