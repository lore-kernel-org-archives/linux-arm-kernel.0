From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 23 Aug 2016 08:26:47 +0200
Subject: [PATCH 0/2] Armada 7k/8k CP110 system controller fixes
Message-ID: <1471933609-8456-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Newly added clock driver for Marvell Armada 7k/8k CP110 HW block occurred
not to be working properly, especially when using two instances of CP110
in Armada 8k. Below tiny patchset comprise fixes for that (prevent from
using uninitialized 'flag' field and static global resources).

Any feedback would be very welcome.

Best regards,
Marcin

Marcin Wojtas (2):
  clk: mvebu: set flags in CP110 gate clock
  clk: mvebu: dynamically allocate resources in Armada CP110 system
    controller

 drivers/clk/mvebu/cp110-system-controller.c | 30 ++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
1.8.3.1
