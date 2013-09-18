From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 18 Sep 2013 15:01:15 -0500
Subject: [PATCH] Renesas clocksource fixes for v3.12
Message-ID: <1379534476-10901-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

please consider this clocksource fix for v3.12.

This pull request is based on renesas-clocksource-for-v3.12
which I believe you have previously pulled.


The following changes since commit 172705f8a40b6e72c53f8cceda079504ed71c4e0:

  clocksource: em_sti: Convert to devm_* managed helpers (2013-08-05 10:47:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocksource-fixes-for-v3.12

for you to fetch changes up to 7b096b40c9d3d2abb6bb747dd148c50c076c2e89:

  clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast (2013-09-05 14:47:53 +0900)

----------------------------------------------------------------
Renesas clocksource fixes for v3.12

* em_sti: Set cpu_possible_mask to fix SMP broadcast

  This resolves a regression introduced by
  f7db706 ("ARM: 7674/1: smp: Avoid dummy clockevent being preferred over
  real hardware clock-event").

  This problem has been present since v3.9-rc4.

----------------------------------------------------------------
Magnus Damm (1):
      clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast

 drivers/clocksource/em_sti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
