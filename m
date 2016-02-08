From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 8 Feb 2016 16:26:47 +0100
Subject: [PATCH 0/2] crypto: atmel-sha - fix .import()/.export() implementation
Message-ID: <cover.1454944687.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches includes two fixes for the atmel-sha.c driver.

The first one fixes the implementation of the import/export hooks, which
did not pass the recent updates in testmgr.c (partial update exercise).
The new implementation now passes the tcrypt tests: tested with
next-20160208.

The second patch fixes a race condition if acquiring the hardware when it
is already busy.

Cyrille Pitchen (2):
  crypto: atmel-sha - fix .import()/.export() implementation
  crypto: atmel-sha - fix race in atmel_sha_final()

 drivers/crypto/atmel-sha.c | 68 ++++++++--------------------------------------
 1 file changed, 12 insertions(+), 56 deletions(-)

-- 
1.8.2.2
