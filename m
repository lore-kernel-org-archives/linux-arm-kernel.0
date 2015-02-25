From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 25 Feb 2015 17:01:51 +0100
Subject: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Message-ID: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is the second version of the patch series to describe i2c adapter quirks
in a generic way. For the motivation, please read description of patch 1. This
is still RFC because I would like to do some more tests on my own, but I need
to write a tool for that. However, I'd really like to have the driver authors
to have a look already. Actual testing is very much appreciated. Thanks to the
Mediatek guys for rebasing their new driver to this framework. That helps, too!

The branch is also here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Thanks,

   Wolfram

Major changes since V1:

* more fine-grained options to describe modes with combined messages.
  This should also cover the Mediatek HW now as well as all other
  permutations I can think of.

* the core code and at91 driver had to be refactored to reflect the
  above change

* added the bcm-iproc driver which came to mainline recently

Wolfram Sang (12):
  i2c: add quirk structure to describe adapter flaws
  i2c: add quirk checks to core
  i2c: at91: make use of the new infrastructure for quirks
  i2c: opal: make use of the new infrastructure for quirks
  i2c: qup: make use of the new infrastructure for quirks
  i2c: cpm: make use of the new infrastructure for quirks
  i2c: axxia: make use of the new infrastructure for quirks
  i2c: dln2: make use of the new infrastructure for quirks
  i2c: powermac: make use of the new infrastructure for quirks
  i2c: viperboard: make use of the new infrastructure for quirks
  i2c: pmcmsp: make use of the new infrastructure for quirks
  i2c: bcm-iproc: make use of the new infrastructure for quirks

 drivers/i2c/busses/i2c-at91.c       | 32 +++++++------------
 drivers/i2c/busses/i2c-axxia.c      | 11 ++++---
 drivers/i2c/busses/i2c-bcm-iproc.c  | 15 +++++----
 drivers/i2c/busses/i2c-cpm.c        | 20 ++++++------
 drivers/i2c/busses/i2c-dln2.c       | 12 +++----
 drivers/i2c/busses/i2c-opal.c       | 22 ++++++-------
 drivers/i2c/busses/i2c-pmcmsp.c     | 42 ++++++++++---------------
 drivers/i2c/busses/i2c-powermac.c   | 10 +++---
 drivers/i2c/busses/i2c-qup.c        | 21 ++++++-------
 drivers/i2c/busses/i2c-viperboard.c | 10 +++---
 drivers/i2c/i2c-core.c              | 62 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 43 +++++++++++++++++++++++++
 12 files changed, 191 insertions(+), 109 deletions(-)

-- 
2.1.4
