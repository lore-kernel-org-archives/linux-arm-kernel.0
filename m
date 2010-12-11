From: davem@davemloft.net (David Miller)
Date: Sat, 11 Dec 2010 12:07:38 -0800 (PST)
Subject: [PATCH] ide: at91_ide.c bugfix for high master clock
In-Reply-To: <1292097745-9680-1-git-send-email-plyatov@gmail.com>
References: <1292097745-9680-1-git-send-email-plyatov@gmail.com>
Message-ID: <20101211.120738.59690708.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Plyatov <plyatov@gmail.com>
Date: Sat, 11 Dec 2010 23:02:25 +0300

> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and at91_ide
> driver does not detect ATA device.
> This patch must be applied on top of my patch for pata_at91 where the
> same bug fixed.
> 
> Signed-off-by: Igor Plyatov <plyatov@gmail.com>

Please submit this as two patches, since different people maintain
the IDE vs. ATA layers.

In fact the dev_warn() change is the only change you made to the
ATA driver and that has nothing to do with the bug fix you are
making here.  So it would belong as a seperate patch submission
anyways.

Thanks.
