From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 17:10:07 +0200
Subject: [PATCH 0/5] constify snd_soc_dai_ops structures
Message-ID: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

---

 sound/soc/blackfin/bf6xx-i2s.c    |    2 +-
 sound/soc/codecs/es8316.c         |    2 +-
 sound/soc/codecs/zx_aud96p22.c    |    2 +-
 sound/soc/rockchip/rockchip_pdm.c |    2 +-
 sound/soc/spear/spdif_in.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
