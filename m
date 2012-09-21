From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Sep 2012 13:31:49 -0700
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <20120921195717.GD2454@linux.vnet.ibm.com>
References: <20120920000351.GI2455@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
Message-ID: <20120921203149.GI28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [120921 12:58]:
> 
> Just to make sure I understand the combinations:
> 
> o	All stalls have happened when running a minimal userspace.
> o	CONFIG_NO_HZ=n suppresses the stalls.
> o	CONFIG_RCU_FAST_NO_HZ (which depends on CONFIG_NO_HZ=y) has
> 	no observable effect on the stalls.

The reason why you may need minimal userspace is to cut down
the number of timers waking up the system with NO_HZ.
Booting with init=/bin/sh might also do the trick for that.

Regards,

Tony
