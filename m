From: apatard@mandriva.com (apatard at mandriva.com)
Date: Thu, 27 May 2010 14:57:37 +0200
Subject: [patch 0/6] kirkwood openrd client audio support - v4
Message-ID: <20100527125737.524554667@mandriva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patchset is an other try to get merged openrd audio support mainline.
The main change is going back to using kirkwood instead of orion, as the 
only orion having i2s is not merged mainline (if I got it right).
I've also fixed the lastests comments on the cs42l51 codec patch.

Arnaud

Changes :
- changed back from orion to kirkwood
- removed cs42l51 adc input register initialisation
- moved the DAPM event macro to soc-dapm
- fixed cs42l51_set_dai_fmt() master/slave check
- removed cs42l51 startup message
- use snd_soc_update_bits() in cs42l51_pdn_event()
