From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 13 Mar 2018 17:48:39 +0100
Subject: [PATCH 0/3] crypto: inside-secure: improve clock management
Message-ID: <20180313164842.20042-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short series fixes the way the clocks are used for the SafeXcel
EIP-197 controller embedded in the Marvell Armada 7K/8K SoCs. On these
SoCs a second one is needed in order to clock the registers. It was
not noticed until now because we relied on the bootloader and also
because the clock driver was wrong.

Thanks to this fix, it would be possible to fix the clock driver
without introducing a regression.

While I was working on the clocks I found a bug in the clock
management which was fixed with the first patch and should be applied
to v4.16.

The second patch is a small improvement which is aim for v4.17 as well
as the last patch.

Thanks,

Gregory

Gregory CLEMENT (3):
  crypto: inside-secure - fix clock management
  crypto: inside-secure - improve clock initialization
  crypto: inside-secure - fix clock resource by adding a register clock

 .../bindings/crypto/inside-secure-safexcel.txt     |  6 ++-
 drivers/crypto/inside-secure/safexcel.c            | 47 +++++++++++++++-------
 drivers/crypto/inside-secure/safexcel.h            |  1 +
 3 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.16.1
