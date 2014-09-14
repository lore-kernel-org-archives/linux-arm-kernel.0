From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 14 Sep 2014 18:10:24 +0100
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean up
 chip identification
Message-ID: <1410714624.3040.38.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch in the series restores the module aliases to m25p80, but
it does so by duplicating the list of names.  This should be suitable
for stable, but it isn't viable in the longer term.

The following patches change the spi-nor interface so that this
duplication is no longer necessary.  This includes removing
spi_nor::read_id, but it could be re-added after this with a different
interface, e.g. returning a flash_info structure (which would need to be
defined in spi_nor.h).

Ben.

Ben Hutchings (5):
  m25p80,spi-nor: Fix module aliases for m25p80
  spi-nor: Remove spi_nor::read_id operation
  spi-nor: Make spi_nor_scan() take a chip type name, not an
    spi_device_id
  spi-nor: Replace struct spi_device_id with struct flash_info
  m25p80,spi-nor: Share the list of supported chip type names again

 drivers/mtd/devices/m25p80.c      |  13 +-
 drivers/mtd/spi-nor/fsl-quadspi.c |   7 +-
 drivers/mtd/spi-nor/spi-nor.c     | 383 +++++++++++++++++++-------------------
 include/linux/mtd/spi-nor.h       |  87 +++++++--
 4 files changed, 279 insertions(+), 211 deletions(-)


-- 
Ben Hutchings
The world is coming to an end.	Please log off.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140914/e8d08292/attachment.sig>
