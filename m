From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 12 Jan 2011 19:19:39 +0100
Subject: [FYI 0/4] arm: mmci: example implementation of double buffering
Message-ID: <1294856383-14187-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci host driver implementation for double buffering is not intended
nor ready for mainline yet. It is only an example of how to implement
pre_req() and post_req(). The reason for this is that the basic DMA
support for MMCI is not complete yet.

This patch series depends on
"[PATCH 0/5] mmc: add double buffering for mmc block requests"

Linus Walleij (1):
  mmci: add PrimeCell generic DMA to MMCI/PL180

Per Forlin (1):
  ARM: mmci: add support for double buffering

Ulf Hansson (2):
  mmci: fixup broken_blockend variant patch
  MMCI: Corrections for DMA

 drivers/mmc/host/mmci.c   |  538 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h   |   21 ++-
 include/linux/amba/mmci.h |   16 ++
 3 files changed, 496 insertions(+), 79 deletions(-)
