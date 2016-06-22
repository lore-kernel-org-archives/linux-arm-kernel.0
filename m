From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 22 Jun 2016 16:23:33 +0300
Subject: [PATCHv2 00/27] crypto: fixes for omap family of devices
Message-ID: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to v1 of the series:

- dropped first patch from the series (crypto: omap-aes: Fix registration of
  algorithms) as it was queued by Herbert already
- modified the second (now first) patch of the series to use runtime auto-
  suspend instead of getting static sync over a cra lifetime
- re-ordered the DTS / hwmod changes in the series, the merge order of
  these must be maintained to avoid issues

Patches #01 .. #14 should be merged via crypto tree, the rest should be
handled by Tony.

Merging the omap / dts parts can be done safely separately, assuming
you just use omap2plus_defconfig (enabling crypto features will
cause some issues without the driver level fixes.)

- Tero
