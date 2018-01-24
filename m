From: maxime.chevallier@smile.fr (Maxime Chevallier)
Date: Wed, 24 Jan 2018 15:10:46 +0100
Subject: [PATCH 0/2] spi: a3700: Remove endianness correction functions
Message-ID: <1516803048-26942-1-git-send-email-maxime.chevallier@smile.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset removes un-necessary endianness swapping functions.

This was detected by sparse, after the commit f68a7dcb91b7
("spi: a3700: Add full-duplex support") introduced a new warning.

This series fix this warning, plus some previously existing ones of
the same nature.

I split this into two patches, since the first applies on an already
mainlined commit, and the other on a recent patch that I sent.

Mark, if you wish I can resend this in another form (just one patch,
or as a rework of my previous patchset
"spi: a3700: Add improvements and full-duplex transfers").

Maxime Chevallier (2):
  spi: a3700: Remove endianness swapping functions when accessing FIFOs
  spi: a3700: Remove endianness swapping for full-duplex transfers

 drivers/spi/spi-armada-3700.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.1.4
