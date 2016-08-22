From: xieyisheng1@huawei.com (Xie Yisheng)
Date: Mon, 22 Aug 2016 21:20:02 +0800
Subject: [RFC PATCH v3 0/2] arm64/hugetlb: enable gigantic page
Message-ID: <1471872004-59365-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 supports different size of gigantic page which can be seen from:
commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
commit 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")

So I tried to use this function by adding hugepagesz=1G in kernel
parameters, with CONFIG_CMA=y. However, when I
echo xx > \
  /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
it failed with the following info:
-bash: echo: write error: Invalid argument

This is a v3 patchset which make gigantic page can be
allocated and freed at runtime for arch arm64,
with CONFIG_CMA=y or other related configs is enabled.

You can see the former discussions at:
https://lkml.org/lkml/2016/8/18/310
https://lkml.org/lkml/2016/8/21/410
 
Xie Yisheng (2):
  mm/hugetlb: Introduce ARCH_HAS_GIGANTIC_PAGE
  arm64 Kconfig: Select gigantic page

 arch/arm64/Kconfig | 1 +
 arch/s390/Kconfig  | 1 +
 arch/x86/Kconfig   | 1 +
 fs/Kconfig         | 3 ++++
 mm/hugetlb.c       | 2 +-
 5 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.7.12.4
