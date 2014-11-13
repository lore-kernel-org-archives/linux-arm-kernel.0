From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 12 Nov 2014 17:59:40 -0800
Subject: [GIT PULL 1/3] soc: few non crtical fixes for 3.19
Message-ID: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-driver-soc

for you to fetch changes up to 148bb0439adeeae466dca31dd4c643e194bee023:

  soc: ti: knav_qmss_queue: Use list_for_each_entry_safe to prevent use after free (2014-11-03 10:22:06 -0800)

----------------------------------------------------------------
Keystone SOC Navigator driver non critical fixes frm Alex for 3.19

	- Use list_for_each_entry_safe to prevent use after free
	- Return proper error if devm_kzalloc fails
	- Use list_first_entry_or_null() at appropriate places

----------------------------------------------------------------
Axel Lin (4):
      soc: ti: Use list_first_entry_or_null() at appropriate places
      soc: ti: knav_qmss_queue: Fix unbalanced locking ins knav_pool_create()
      soc: ti: knav_qmss_queue: Return proper error if devm_kzalloc fails
      soc: ti: knav_qmss_queue: Use list_for_each_entry_safe to prevent use after free

 drivers/soc/ti/knav_qmss.h       |  8 ++++----
 drivers/soc/ti/knav_qmss_queue.c | 13 +++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)
