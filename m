From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Feb 2014 21:36:28 +0100
Subject: [PATCH 0/5] mv64xxx updates
In-Reply-To: <20140213094117.GA3934@katana>
References: <20140213094117.GA3934@katana>
Message-ID: <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, this is a series I came up with trying to fix the issue found by Kevin.
Patches 1+2 are hopefully fixing the bug (in theory, I don't have the HW).
Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), then 4+5
are further cleanup possibilities. And there is still more potential, I mainly
wanted to give some inspiration and awareness that the driver could need some
more love. Please test at least 1+2, comments to 3-5 very welcome.

Sorry for the delay, I got distracted by an NMI.

Wolfram Sang (5):
  i2c: mv64xxx: put offload check into offload prepare function
  i2c: mv64xxx: refactor message start to ensure proper initialization
  i2c: mv64xxx: refactor send_start
  i2c: mv64xxx: directly call send_start when initializing transfer
  i2c: mv64xxx: refactor initialization for new msgs

 drivers/i2c/busses/i2c-mv64xxx.c | 67 ++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

-- 
1.8.5.1
