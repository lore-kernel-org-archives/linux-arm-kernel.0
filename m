From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 15:10:04 -0700
Subject: [GIT PULL 02/10] ARM: tegra: dependency from the ASoC tree
In-Reply-To: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
References: <1387231812-5701-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1387231812-5701-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the work so far on dmaengine for v3.14, it is being cross merged
into the Tegra tree to support a large DMA overhaul there.  The main
additions are a change in the DMA request API which allows better
interaction at system startup using deferred probes and methods for
overriding the default device and channel names used to request DMA.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>

----------------------------------------------------------------

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-dma-v3.14

or:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git asoc-dma-v3.14

for you to fetch changes up to e9036c2a60f368b8ddc349fbbcde918ed32ab597:

  ASoC: dmaengine: fix deferred probe detection

----------------------------------------------------------------

Lars-Peter Clausen (2):
      ASoC: Add resource managed snd_dmaengine_pcm_register()
      ASoC: generic-dmaengine-pcm: Set BATCH flag when residue reporting is not supported

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/dma' into asoc-dma
      Merge branch 'topic/defer_probe' of git://git.infradead.org/users/vkoul/slave-dma into asoc-dma

Stephen Warren (6):
      ASoC: restructure dmaengine_pcm_request_chan_of()
      ASoC: don't leak on error in snd_dmaengine_pcm_register
      ASoC: dmaengine: add custom DMA config to snd_dmaengine_pcm_config
      dma: add channel request API that supports deferred probe
      ASoC: dmaengine: support deferred probe for DMA channels
      ASoC: dmaengine: fix deferred probe detection

 drivers/dma/dmaengine.c               | 35 +++++++++--
 drivers/dma/of-dma.c                  | 15 +++--
 include/linux/dmaengine.h             |  8 +++
 include/sound/dmaengine_pcm.h         | 10 ++++
 sound/soc/soc-devres.c                | 41 +++++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c | 94 +++++++++++++++++++++++-------
 6 files changed, 171 insertions(+), 32 deletions(-)
