From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:14:11 +0900
Subject: [GIT PULL 00/11] Second Round of Renesas SH SCI updates for v3.14
Message-ID: <cover.1387887969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas SH SCI updates for v3.14.

They have been acked by Greg Kroah-Hartman to be taken
through my tree. The reason for this is that they are dependencies
for subsequent changes to use the common clock framework.

This pull-request is based on the first round of such changes,
tagged as renesas-sh-sci-for-v3.14, which I have previously sent
a pull-request for.


The following changes since commit b016b646e8676858f39ea9be760494b04b9ee0af:

  serial: sh-sci: Convert to clk_prepare/unprepare (2013-12-14 09:59:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-sci2-for-v3.14

for you to fetch changes up to ec09c5eb491834d4011c72538e58d8b7096076bd:

  serial: sh-sci: Rework baud rate calculation (2013-12-24 11:17:53 +0900)

----------------------------------------------------------------
Second Round of Renesas SH SCI updates for v3.14

* Rework baud rate calculation
* Compute overrun_bit without using baud rate algo
* Remove unused GPIO request code
* Move overrun_bit and error_mask fields out of pdata
* Support resources passed through platform resources
* Don't check IRQ in verify port operation
* Set the UPF_FIXED_PORT flag
* Remove duplicate interrupt check in verify port op
* Simplify baud rate calculation algorithms
* Remove baud rate calculation algorithm 5
* Sort headers alphabetically

----------------------------------------------------------------
Laurent Pinchart (11):
      serial: sh-sci: Sort headers alphabetically
      serial: sh-sci: Remove baud rate calculation algorithm 5
      serial: sh-sci: Simplify baud rate calculation algorithms
      serial: sh-sci: Remove duplicate interrupt check in verify port op
      serial: sh-sci: Set the UPF_FIXED_PORT flag
      serial: sh-sci: Don't check IRQ in verify port operation
      serial: sh-sci: Support resources passed through platform resources
      serial: sh-sci: Move overrun_bit and error_mask fields out of pdata
      serial: sh-sci: Remove unused GPIO request code
      serial: sh-sci: Compute overrun_bit without using baud rate algo
      serial: sh-sci: Rework baud rate calculation

 drivers/tty/serial/sh-sci.c | 281 +++++++++++++++++++++-----------------------
 drivers/tty/serial/sh-sci.h |   2 +-
 include/linux/serial_sci.h  |  34 ++----
 3 files changed, 142 insertions(+), 175 deletions(-)
