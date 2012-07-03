From: mturquette@ti.com (Mike Turquette)
Date: Tue, 3 Jul 2012 16:28:10 -0700
Subject: [GIT PULL] clk: fixes for 3.5-rc6
Message-ID: <20120703232810.GA28439@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have one trivial fix for the common clk framework towards 3.5-rc6.
This issue was introduced by the last set of fixes, unfortunately.

Thanks,
Mike

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mturquette/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 863b13271f1608ab3af6f7a371047d9a66693e38:

  clk: fix parent validation in __clk_set_parent() (2012-07-03 12:05:14 -0700)

----------------------------------------------------------------
The previous set of common clk fixes for -rc5 left an uninitialized int
which could lead to bad array indexing when switching clock parents.
The issue is fixed with a trivial change to the code flow in
__clk_set_parent.

----------------------------------------------------------------
Rajendra Nayak (1):
      clk: fix parent validation in __clk_set_parent()

 drivers/clk/clk.c |   28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)
