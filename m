From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 Sep 2016 18:22:11 +0300
Subject: [PATCH 0/8] crypto: omap-sham: convert to sg based data engine
Message-ID: <1474298539-23897-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series converts the omap-sham buffer handling towards a scatterlist
approach. This avoids the need to have a huge internal buffer within the
driver, and also allows us to properly implement export/import for the
driver. I tried splitting up the changes to some sane patches, but this
was rather difficult due to the fact that this is largely a complete
rewrite of portions of the driver. Patch #6 is a prime example of this
being pretty large, but splitting this up would break bisectability.
Hopefully the patch is still understandable though.

Crypto manager tests work fine at least on omap3/am3/am4/dra7 SoC:s.
(Something is broken with test farm again and could not try omap2/omap4.)

Also tested tcrypt SHA performance on DRA7 and it seems to be working
fine with different buffer sizes.

My test branch is also available here for interested parties:
tree: https://github.com/t-kristo/linux-pm.git
breanch: 4.8-rc1-crypto

-Tero
