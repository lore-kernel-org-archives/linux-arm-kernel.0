From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 6 May 2012 22:08:25 -0700
Subject: [PATCH 0/5] more clk-next fixes
Message-ID: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These five patches are hopefully the final set of core framework changes
for 3.5.  There is the obligatory MAINTAINERS file change, three new
fixes and the fixed-factor clock patch.  That last patch is being
reposted since three bugs were found in it (one on the list, two in my
testing).

If no one complains about these then I'll commit them to clk-next and
(finally) send my pull request to Arnd.

Note that the Orion patches aren't here, but I figure that Andrew L.
probably wants to check those against the final clk-next before I pull
them.

Regards,
Mike

Mike Turquette (4):
  MAINTAINERS: add entry for common clk framework
  clk: prevent spurious parent rate propagation
  clk: remove COMMON_CLK_DISABLE_UNUSED
  clk: mux: assign init data

Sascha Hauer (1):
  clk: add a fixed factor clock

 MAINTAINERS                    |   10 ++++
 drivers/clk/Kconfig            |   11 -----
 drivers/clk/Makefile           |    2 +-
 drivers/clk/clk-fixed-factor.c |   95 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-mux.c          |    1 +
 drivers/clk/clk.c              |    9 +++-
 include/linux/clk-private.h    |   20 ++++++++
 include/linux/clk-provider.h   |   23 ++++++++++
 8 files changed, 156 insertions(+), 15 deletions(-)
 create mode 100644 drivers/clk/clk-fixed-factor.c

-- 
1.7.5.4
