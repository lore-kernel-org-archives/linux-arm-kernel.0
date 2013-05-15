From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 15 May 2013 11:40:18 +0200
Subject: [PATCH 0/4] mmc: mmci: Add support for UHS cards
Message-ID: <1368610823-14113-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

UHS cards in mode SDR12|25 operates at 1.8V I/O voltage. This patchset
adds support to handle the corresponding voltage switch from the default
2.7-3.6 I/O voltage to 1.8V.

The first patch, "Fixup regulator handling for vqmmc" has recently been
sent as a separate patch, since it is a pure bugfix. Nevertheless this
patchset depends on this patch, thus I decided to fold it here as well.

Host capabilities for SDR12 and SDR25 needs to be set to enable support,
but that will be handled outside this patchset.

Ulf Hansson (4):
  mmc: mmci: Fixup regulator handling for vqmmc
  mmc: mmci: Support signal voltage switch for UHS cards
  mmc: mmci: Cache MMCIDATACTRL register
  mmc: mmci: Add card_busy function to improve UHS card support

 drivers/mmc/host/mmci.c |   94 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |    4 ++
 2 files changed, 90 insertions(+), 8 deletions(-)

-- 
1.7.10
