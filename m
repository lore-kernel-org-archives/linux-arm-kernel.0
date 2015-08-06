From: mw@semihalf.com (Marcin Wojtas)
Date: Thu,  6 Aug 2015 19:00:27 +0200
Subject: [PATCH 0/3] Fixes for the network driver of Marvell Armada 375 SoC
In-Reply-To: <y>
References: <y>
Message-ID: <1438880430-5480-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a set of three patches that fix long-lasting problems implemented in
the initial support for the Armada 375 network controller.

Due to an inappropriate concept of handling the per-CPU sent packets'
processing on TX path the driver numerous problems occured, such as RCU
stalls. Those have been fixed, of which details you can find in the commit
logs. The patches were intensively tested on top of v4.2-rc5.

I'm looking forward to any comments or remarks.

Thanks,
Marcin

Marcin Wojtas (3):
  net: mvpp2: remove excessive spinlocks from driver initialization
  net: mvpp2: enable proper per-CPU TX buffers unmapping
  net: mvpp2: replace TX coalescing interrupts with hrtimer

 drivers/net/ethernet/marvell/mvpp2.c | 244 ++++++++++++++++++++++++-----------
 1 file changed, 167 insertions(+), 77 deletions(-)

-- 
1.8.3.1
