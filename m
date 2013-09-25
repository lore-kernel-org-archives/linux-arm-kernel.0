From: tony@atomide.com (Tony Lindgren)
Date: Wed, 25 Sep 2013 16:47:32 -0700
Subject: [PATCH 0/2] patches to enable SDIO interrupt support for omap_hsmmc
 for v3.13
Message-ID: <20130925234544.3745.55170.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some patches to enable the SDIO interrupt support
for omap_hsmmc. Note that this series does not do the remux,
but relies on working io chain wake-up events. So omaps that
do require remuxing for wake-up events need more work, but
let's do this first.

Regards,

Tony

---

Tony Lindgren (2):
      mmc: omap_hsmmc: Fix context save and restore for DT
      mmc: omap_hsmmc: Enable SDIO interrupt


 drivers/mmc/host/omap_hsmmc.c |  116 +++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 41 deletions(-)

-- 
Signature
