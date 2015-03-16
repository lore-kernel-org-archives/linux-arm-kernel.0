From: s-anna@ti.com (Suman Anna)
Date: Mon, 16 Mar 2015 15:54:52 -0500
Subject: [PATCH 0/2] Couple of DRA7 hwmod patches on Timers
Message-ID: <1426539294-28375-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Following are couple of DRA7 hwmod patches for the GPTimers.
Patches based on 4.0-rc1.

The first patch adds the data for timers 13 through 16, the DT
nodes are already present, and when enabled without the hwmod
data triggers a l3_noc interrupt and hangs the kernel boot [1].
The boot hang can also be fixed by checking the return status
of pm_runtime_get_sync() in the OMAP dmtimer probe, I will post
a separate fix for that.

Second patch is a minor fix.

regards
Suman

[1] http://pastebin.ubuntu.com/10611882/

Suman Anna (2):
  ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
  ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 98 ++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

-- 
2.3.2
