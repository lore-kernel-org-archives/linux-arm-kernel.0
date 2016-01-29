From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Jan 2016 17:26:01 +0100
Subject: [PATCH net 0/6] mvneta fixes for SMP
Message-ID: <1454084767-24715-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following this bug report:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/468173 and the
suggestions from Russell King, I reviewed all the code involving
multi-CPU. It ended with this series of patches which should improve
the stability of the driver.

The first patch fix a real bug, the other fix potential issues in the
driver.

Thanks,

Gregory

Gregory CLEMENT (6):
  net: mvneta: Fix for_each_present_cpu usage
  net: mvneta: Use on_each_cpu when possible
  net: mvneta: Remove unused code
  net: mvneta: Modify the queue related fields from each cpu
  net: mvneta: The mvneta_percpu_elect function should be atomic
  net: mvneta: Fix race condition during stopping

 drivers/net/ethernet/marvell/mvneta.c | 160 +++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 78 deletions(-)

-- 
2.5.0
