From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Dec 2015 22:02:20 +0100
Subject: [GIT PULL] Allwinner clocks changes for 4.5
Message-ID: <20151217210220.GA25086@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Please pull the following changes for the 4.5 merge window.

Thanks!
Maxime

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-clocks-for-4.5

for you to fetch changes up to fee3103ac3c0aeab52b337903f5af3cd3b3c02d8:

  clk: sunxi: fix handling return value of of_property_match_string (2015-12-14 13:54:11 +0100)

----------------------------------------------------------------
Allwinner clocks changes for 4.5

Clock patches for the Allwinner SoCs:
  - H3 clocks
  - A10/A20 Video Engine clocks
  - DRAM gates
  - A80 special CPU clock

----------------------------------------------------------------
Andrzej Hajda (1):
      clk: sunxi: fix handling return value of of_property_match_string

Chen-Yu Tsai (5):
      clk: sunxi: Add sun9i A80 apbs gates support
      clk: sunxi: Add sun9i A80 cpus (cpu special) clock support
      clk: sunxi: Add DRAM gates support for sun4i-a10
      clk: sunxi: Add VE (Video Engine) module clock driver for sun[457]i
      clk: sunxi: Add CLK_OF_DECLARE support for sun8i-a23-apb0-clk driver

Dan Carpenter (1):
      clk: sunxi: signedness bug in sun8i_h3_bus_gates_init()

Jens Kuske (1):
      clk: sunxi: Add H3 clocks support

Reinder de Haan (1):
      clk: sunxi: Add support for the H3 usb phy clocks

 Documentation/devicetree/bindings/clock/sunxi.txt |  10 +
 drivers/clk/sunxi/Makefile                        |   5 +
 drivers/clk/sunxi/clk-a10-ve.c                    | 171 +++++++++++++++
 drivers/clk/sunxi/clk-simple-gates.c              |  14 ++
 drivers/clk/sunxi/clk-sun8i-apb0.c                |  80 ++++++--
 drivers/clk/sunxi/clk-sun8i-bus-gates.c           | 112 ++++++++++
 drivers/clk/sunxi/clk-sun9i-cpus.c                | 240 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c                     |   6 +
 drivers/clk/sunxi/clk-usb.c                       |  12 ++
 9 files changed, 638 insertions(+), 12 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-ve.c
 create mode 100644 drivers/clk/sunxi/clk-sun8i-bus-gates.c
 create mode 100644 drivers/clk/sunxi/clk-sun9i-cpus.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/e742d446/attachment.sig>
