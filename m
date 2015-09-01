From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 1 Sep 2015 17:41:10 +0300
Subject: [PATCH 0/2] arm64: introduce run-time detection of aarch32 support
Message-ID: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to avoid loading aarch32 binaries if COMPAT is enabled, but
aarch32 is not supported by specific platform.

First patch fixes hidden header dependencies in arch/arm64/include/asm/cpufeature.h.
It's not related to the issue, but helps to avoid build failure that happens
if one applies second patch only.

Second patch adds run-time detection of aarch32 support, and rejects kernel to
load such binaries, if not supported.

Tested on ThunderX.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Yury Norov (2):
  arm64: cpufeature.h: resolve hidden header dependencies
  arm64: don't load 32-bit binaries if platform has no aarch32_el0

 arch/arm64/include/asm/cpufeature.h | 6 ++++++
 arch/arm64/include/asm/elf.h        | 6 ++++--
 arch/arm64/kernel/cpuinfo.c         | 9 +++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.1.4
