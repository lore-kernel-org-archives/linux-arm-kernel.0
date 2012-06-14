From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 19:24:10 +0300
Subject: [PATCH v2 00/17] Big OMAP I2C Cleanup
Message-ID: <1339691067-919-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I have dropped a few patches from the series and also
tested every single patch on my pandaboard. I2C messages
are still working fine with panda after each patch.

There's still lots of work to be done on the i2c-omap.c
driver but it's now easier to read, IMO.

Changes since v1:
	- removed tabification on patch 6/17
	- removed dev_err() which was introduced on patch 09/17

Felipe Balbi (17):
  i2c: omap: simplify num_bytes handling
  i2c: omap: decrease indentation level on data handling
  i2c: omap: add blank lines
  i2c: omap: simplify omap_i2c_ack_stat()
  i2c: omap: split out [XR]DR and [XR]RDY
  i2c: omap: improve 1p153 errata handling
  i2c: omap: re-factor receive/transmit data loop
  i2c: omap: switch over to do {} while loop
  i2c: omap: ack IRQ in parts
  i2c: omap: get rid of the "complete" label
  i2c: omap: switch to devm_* API
  i2c: omap: switch to platform_get_irq()
  i2c: omap: bus: add a receiver flag
  i2c: omap: simplify errata check
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: simplify IRQ exit path
  i2c: omap: resize fifos before each message

 drivers/i2c/busses/i2c-omap.c |  385 +++++++++++++++++++++++------------------
 1 file changed, 220 insertions(+), 165 deletions(-)

-- 
1.7.10.4
