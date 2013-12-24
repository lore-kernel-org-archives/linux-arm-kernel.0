From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:30:07 +0900
Subject: [GIT PULL 0/4] Third Round of Renesas SH SCI Updates for v3.14
Message-ID: <cover.1387890410.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this third round of Renesas SH SCI updates for v3.14.

This pull request is based on a merge of the following:

* Renesas SH based SoC updates for v3.14,
  tagged as renesas-sh-soc-for-v3.14, which I will
  also send a pull-request for today.

* Third Round of Renesas ARM based SoC updates for v3.14,
  tagged as renesas-soc3-for-v3.14, which I will
  also send a pull-request for today.

Both of the above branches are based on

* Second Round of Renesas SH SCI Updates for v3.14
  tagged as renesas-sh-sci2-for-v3.14, which I will
  also send a pull-request for today.

The reason for this merge is to provide dependencies for the
patches in this series. In a nutshell there was a round of
driver updates, followed by SoC updates to use the new driver code,
followed by more driver updates.


The following changes since commit 20f4e334272dc191e475039d68a3bf3eb46ec66e:

  Merge branch 'sh-soc' into sh-sci2-base (2013-12-24 21:50:13 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci3-for-v3.14

for you to fetch changes up to 20bdcab8268cb05702e12ae9013be96ecc7ec3a6:

  serial: sh-sci: Add OF support (2013-12-24 21:50:54 +0900)

----------------------------------------------------------------
Third Round of Renesas SH SCI Updates for v3.14

* Add Device Tree Support
* Remove platform data mapbase and irqs fields
* Remove platform data scbrr_algo_id field

----------------------------------------------------------------
Bastian Hecht (1):
      serial: sh-sci: Add OF support

Laurent Pinchart (3):
      serial: sh-sci: Remove platform data scbrr_algo_id field
      serial: sh-sci: Remove platform data mapbase and irqs fields
      serial: sh-sci: Add device tree bindings documentation

 .../bindings/serial/renesas,sci-serial.txt         |  46 +++++
 drivers/tty/serial/sh-sci.c                        | 187 +++++++++++++++------
 include/linux/serial_sci.h                         |  36 ----
 3 files changed, 183 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
