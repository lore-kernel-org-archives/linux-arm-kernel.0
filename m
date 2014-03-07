From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Fri,  7 Mar 2014 14:19:24 +0530
Subject: [RFC PATCH v2 0/1] arm64: Boot time configuration of Intermediate
 Physical Address size
Message-ID: <1394182165-10480-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support to read the implemented physical address size of
a platform during boot-time and configure the translation control
registers.

Changes since v1:
----------------
- Use BFI instruction instead of combination of UBFIZ and ORR.


Radha Mohan Chintakuntla (1):
  arm64: Add boot time configuration of Intermediate Physical Address
    size

 arch/arm64/include/asm/kvm_arm.h       |   15 ++++++---------
 arch/arm64/include/asm/pgtable-hwdef.h |    5 ++---
 arch/arm64/kvm/hyp-init.S              |    6 ++++++
 arch/arm64/mm/proc.S                   |    8 +++++++-
 4 files changed, 21 insertions(+), 13 deletions(-)
