From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 May 2013 15:11:09 -0600
Subject: [PATCH 0/2] ARM: tegra: a couple clock bug-fixes 
Message-ID: <1367874671-11474-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Arnd, Olof,

The following two patches fix a couple issues in the Tegra20 clock driver
that show up on specific platforms. They were sent a little late for 3.9,
and I forgot to include them for 3.10 since they weren't reposted:-(

Patch 1 is clearly a bug-fix. Someone pedantic could argue that patch 2
is a new feature since it's the last piece to enabling AC'97 support, but
I'd argue that it's a bug in the clock driver that it didn't support this
clock when it was first written:-)

These patches logically belong to Tegra's for-3.10/clk branch, but feel
free to apply them where is easiest; it'd be fine to defer them to a post-
3.10-rc1 fixes branch too if you want.

Lucas Stach (2):
  clk: tegra: remove USB from clk init table
  clk: tegra: add ac97 controller clock

 drivers/clk/tegra/clk-tegra20.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
1.7.10.4
