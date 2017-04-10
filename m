From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Apr 2017 10:06:27 -0700
Subject: [GIT PULL] omap deferred probe regression fix
Message-ID: <pull-1491843962-982485>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 351b7c490700747d1dba1b0a10fbfe3448d11c35:

  ARM: omap2+: Revert omap-smp.c changes resetting CPU1 during boot (2017-03-27 10:10:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/fixes-rc6-signed

for you to fetch changes up to 04abaf07f6d5cdf22b7a478a86e706dfeeeef960:

  ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer (2017-04-04 08:49:56 -0700)

----------------------------------------------------------------
Regression fix for omap interconnect code for deferred probe.
Without this fix we can get PM related warnings for devices that
use deferred probe. If necessary, this fix can wait for the
v4.12 merge window no problem.

----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: omap_device: Sync omap_device and pm_runtime after probe defer

 arch/arm/mach-omap2/omap_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)
