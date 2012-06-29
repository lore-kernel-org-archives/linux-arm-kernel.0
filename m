From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 15:43:20 +0530
Subject: [PATCHv3 00/17] I2C Big cleanup
Message-ID: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have dropped a few patches from the series and also
tested every single patch on my pandaboard.

There's still lots of work to be done on the i2c-omap.c
driver but it's now easier to read, IMO.

Changes since v1:
       - removed tabification on patch 6/17
       - removed dev_err() which was introduced on patch 09/17
Changes since v2:
	- do not set full fifo depth in the RDR interrupt.
	- some changelog updates.
	- rebase to the Wolfram's tree.

Tested on omap4sdp and 3430sdp.
Functional testing.
Also did suspend resume.
For omap3 the per domain seems to be OK.

This applies on Wolfram's i2c-embedded/for-next branch
plus the below series
http://www.spinics.net/lists/linux-omap/msg72901.html


are available in the git repository at:
  git://gitorious.org/linus-tree/linus-tree.git for_next/omap/big_cleanup



Felipe Balbi (17):
  i2c: omap: switch to devm_* API
  i2c: omap: simplify num_bytes handling
  i2c: omap: decrease indentation level on data handling
  i2c: omap: add blank lines
  i2c: omap: simplify omap_i2c_ack_stat()
  i2c: omap: split out [XR]DR and [XR]RDY
  i2c: omap: improve i462 errata handling
  i2c: omap: re-factor receive/transmit data loop
  i2c: omap: switch over to do {} while loop
  i2c: omap: ack IRQ in parts
  i2c: omap: switch to platform_get_irq()
  i2c: omap: bus: add a receiver flag
  i2c: omap: simplify errata check
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: simplify IRQ exit path
  i2c: omap: resize fifos before each message
  i2c: omap: get rid of the "complete" label

 drivers/i2c/busses/i2c-omap.c |  394 ++++++++++++++++++++++++-----------------
 1 files changed, 232 insertions(+), 162 deletions(-)

-- 
1.7.5.4
