From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Dec 2014 17:33:44 +0100
Subject: [PATCH 0/2] i2c: i2c-mv64xxx: fix offload support
Message-ID: <1418315626-9552-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

Please consider this set of two patches (one cleanup and one fix) that
aim at making the i2c-mv64xxx offload support work properly for SMBus
type transfers and make sure it only gets used for transactions where
it can really be used (in order to comply with the expectations of the
I2C subsystem in terms of repeated start usage between messages of the
same xfer).

Without this patch, a platform like the Armada XP WRT1900AC doesn't
even boot completely, because an I2C LED controller driver triggers
some SMBus transfers that are do not work with the current i2c-mv64xxx
driver.

They apply on top of 3.18.

Thanks,

Thomas

Thomas Petazzoni (2):
  i2c: i2c-mv64xxx: use BIT() macro for register value definitions
  i2c: i2c-mv64xxx: rework offload support to fix several problems

 drivers/i2c/busses/i2c-mv64xxx.c | 325 +++++++++++++++++++++++----------------
 1 file changed, 194 insertions(+), 131 deletions(-)

-- 
2.1.0
