From: elder@linaro.org (Alex Elder)
Date: Mon, 07 Apr 2014 13:43:52 -0500
Subject: [GIT PULL] clk: bcm281xx: urgent fix for older compilers
Message-ID: <5342F1E8.10803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike, I learned this morning that my clock code (now in
Linus Torvald's master branch) uses a feature that is not
supported in older versions of gcc.  Specifically, the
code made use of unnamed struct and union fields, e.g.:

    struct foo {
	u64	bar;
	union {
	    u32	    baz;
	    bool    quux;
	};
    };

I've prepared a patch that resolves this.  Would you please
pull this critical fix for 3.15-rc1 and get it to Linus as
soon as possible?  Thank you.

					-Alex

The following changes since commit 18a1a7a1d862ae0794a0179473d08a414dd49234:

  Merge
git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile
(2014-04-06 08:11:57 -0700)

are available in the git repository at:


  git://git.linaro.org/landing-teams/working/broadcom/kernel.git
pull/urgent-for-mturquette

for you to fetch changes up to a7a7eba0eeff8f839cde4b327b56dc057a1a48d7:

  clk: bcm281xx: don't use unnamed structs or unions (2014-04-07
13:29:34 -0500)

----------------------------------------------------------------
Alex Elder (1):
      clk: bcm281xx: don't use unnamed structs or unions

 drivers/clk/bcm/clk-kona-setup.c |   33 ++++++++++----------
 drivers/clk/bcm/clk-kona.c       |   64
++++++++++++++++++++------------------
 drivers/clk/bcm/clk-kona.h       |   28 ++++++++---------
 3 files changed, 64 insertions(+), 61 deletions(-)
