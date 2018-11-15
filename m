From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2018 13:14:51 -0800
Subject: Regression in next with spi return from transfer_one()
Message-ID: <20181115211451.GH53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Commit 810923f3bf06 ("spi: Deal with slaves that return from
transfer_one() unfinished") causes a regression at least on
droid 4 with SPI PMIC and regulators on the PMIC. During boot
the device just hangs there waiting for rootfs to appear on
MMC. Reverting 810923f3bf06 makes things work again.

Any ideas why this might be?

Regards,

Tony
