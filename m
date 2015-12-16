From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Dec 2015 17:14:44 +0800
Subject: [PATCH 0/2] bus: sunxi-rsb: fix primary PMIC and peripheral IC
 address mapping
Message-ID: <1450257286-1645-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are 2 fixes for the sunxi-rsb driver. There were some typos in the
hardware address mapping table, but as long as the assigned address
matched what the bootloader used, it still worked fine. The only
indication was "failed to set runtime address" error messages which I
mistook for some hardware quirk.

I looked deeper when the AC100 on my A80 boards refused to respond.

Patch 1 fixes the hardware address for primary PMICs (AXP223, AXP809...).
This is the part that still worked fine despite the error because the
runtime address matches the one set by the bootloader.

Patch 2 fixes the assigned runtime address for the peripheral IC
(AC100/AC200). This part does not work due to the runtime address being
invalid.

Maxime asked me to send them directly to you. Please pick them up for 4.4.


Regards
ChenYu

P.S. my primary email is down this week, but should be fixed by the end
of the week.

Chen-Yu Tsai (2):
  bus: sunxi-rsb: Fix primary PMIC mapping hardware address
  bus: sunxi-rsb: Fix peripheral IC mapping runtime address

 drivers/bus/sunxi-rsb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.6.4
