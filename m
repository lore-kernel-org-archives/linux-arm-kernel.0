From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 13 Oct 2017 17:13:35 -0600
Subject: [PATCH 0/2] fix lockdep warnings in s5p_mfc and exynos-gsc vb2 drivers
Message-ID: <cover.1507935819.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Driver mmap functions shouldn't hold lock when calling vb2_mmap(). The
vb2_mmap() function has its own lock that it uses to protect the critical
section.

Reference: commit log for f035eb4e976ef5a059e30bc91cfd310ff030a7d3

Shuah Khan (2):
  media: exynos-gsc: fix lockdep warning
  media: s5p-mfc: fix lockdep warning

 drivers/media/platform/exynos-gsc/gsc-m2m.c | 5 -----
 drivers/media/platform/s5p-mfc/s5p_mfc.c    | 3 ---
 2 files changed, 8 deletions(-)

-- 
2.7.4
