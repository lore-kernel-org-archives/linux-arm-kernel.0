From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 24 Dec 2014 17:36:59 +0800
Subject: [PATCH v2 0/3] ASoC: rockchip: i2s: fix watermark to 16 and maxburst
 to 4
In-Reply-To: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1419413822-11539-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make Bus DMA works more efficiency, DMA may work in burst mode,
   we set the watermark of transmit and receive reach to 16 bits.

Jianqun Xu (3):
  ASoC: rockchip: i2s: fix error defination of transmit data level
  ASoC: rockchip: i2s: set TDL and RDL to 16 samples
  ASoC: rockchip: i2s: fix maxburst of dma data to 4

 sound/soc/rockchip/rockchip_i2s.c | 8 ++++++--
 sound/soc/rockchip/rockchip_i2s.h | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
changes since v1:
- modify commit message suggested by dgreid
- add patch to fix maxburst
1.9.1
