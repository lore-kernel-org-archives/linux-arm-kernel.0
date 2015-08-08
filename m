From: oliver@schinagl.nl (Olliver Schinagl)
Date: Sat,  8 Aug 2015 21:41:51 +0200
Subject: [PATCH v6] ARM: sun4i: spi: Allow transfers larger than FIFO size
Message-ID: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandru sent this patch over a year and a half ago, and I believe several
tree's have been carrying it since. We've been using this patch on an
Olimex OLinuxIno Lime1 and Lime2 using the mmc-spi driver to access SD cards
without problems. So bumping this and adding my

Tested-by: Olliver Schinagl <oliver@schinagl.nl>

Changes from v5as warned by checkpatch. No functional changes.
 * Added some newlines to make checkpatch happy. No functional changes.

Changes from v4:
 * use min3() instead of two if statements in sun4i_spi_fill_fifo()
 * fix trivial whitespace issue in if statement in sun4i_spi_handler()
 * use consistent style in assigning 'reg' in the added functions.

Alexandru Gagniuc (1):
  ARM: sun4i: spi: Allow transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 76 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 9 deletions(-)

-- 
2.1.4
