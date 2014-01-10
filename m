From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 10 Jan 2014 16:56:45 +0530
Subject: [GIT PULL] A DaVinci SoC update for v3.14
Message-ID: <52CFD8F5.5010100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.14/soc

for you to fetch changes up to 4408c26bc37fa8ada493ad41a6c7659b76fff483:

  ARM: davinci: clock: return 0 upon error from clk_round_rate() (2013-11-27 14:48:33 +0530)

----------------------------------------------------------------
A patch to fix the return value of clk_round_rate()

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: davinci: clock: return 0 upon error from clk_round_rate()

 arch/arm/mach-davinci/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index dc9a470..985e5fd 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
+		return 0;
 
 	if (clk->round_rate)
 		return clk->round_rate(clk, rate);
