From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 2 May 2016 07:21:17 -0700
Subject: [PATCH omap 0/6] Fix OMAP uses of RCU from idle loop
Message-ID: <20160502142117.GA2911@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

The following series fixes a number of uses of RCU from the idle loop.
These are all due to tracing, so the fix is simply to append _rcuidle
to the event-tracing call.

							Thanx, Paul

------------------------------------------------------------------------

 arch/arm/kernel/smp.c             |    2 +-
 arch/arm/mach-omap2/powerdomain.c |    9 +++++----
 drivers/base/power/runtime.c      |   14 +++++++-------
 drivers/clk/clk.c                 |    8 ++++----
 4 files changed, 17 insertions(+), 16 deletions(-)
