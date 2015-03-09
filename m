From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon,  9 Mar 2015 18:03:43 +0000
Subject: [PATCH 0/2] of: fix handling of '/' in path options
Message-ID: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7914a7c5651a ("of: support passing console options with
stdout-path") neglected to deal with '/'s appearing past the ':'
terminator.

This mini-series fixes this oversight and adds the tests to prove it.

Leif Lindholm (1):
  of: fix handling of '/' in options for of_find_node_by_path()

Peter Hurley (1):
  of: unittest: Add options string testcase variants

 drivers/of/base.c     | 23 +++++++++++++++--------
 drivers/of/unittest.c | 11 +++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.1.4
