From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:14 -0800
Subject: [PATCHv2 0/4] ARM64: Improve copy_page and copy_template for ThunderX
Message-ID: <1452668899-3553-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2.  I expanded it to include copy_template as it was a simple
extension to the new version of the patch.
Changes since v1:
1) Add infastructure for checking MIDR for features
2) Use the copy_page version from Will Deacon 
3) Add prefetching feature
4) Add prefetching to copy_page
5) Add prefetching to copy_template


Andrew Pinski (5):
  ARM64: Support midr detected cpufeature
  ARM64 Improve copy_page for 128 byte cache line
  ARM64: Add Needs software prefetching cap
  ARM64: Patch in prefetching for copy_page is requested
  ARM64: Patch in prefetching in copy_template

 arch/arm64/include/asm/cpufeature.h |   29 ++++++++++++++--
 arch/arm64/include/asm/cputype.h    |    7 ++++
 arch/arm64/kernel/cpu_errata.c      |   26 --------------
 arch/arm64/kernel/cpufeature.c      |   27 ++++++++++++++-
 arch/arm64/lib/copy_page.S          |   64 ++++++++++++++++++++++++++++++----
 arch/arm64/lib/copy_template.S      |   12 ++++++
 arch/arm64/lib/memcpy.S             |    2 +
 7 files changed, 129 insertions(+), 38 deletions(-)

-- 
1.7.2.5
