From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon,  3 Mar 2014 12:22:19 +0530
Subject: [RFC PATCH 0/1] arm64: Boot time configuration of Intermediate
Message-ID: <1393829540-24847-1-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support to read the implemented physical address size of
a platform during boot-time and configure the translation control
registers.

This patch is a re-written version of
http://www.spinics.net/lists/arm-kernel/msg311035.html with a new
subject line to suit the actual thing being done.


Radha Mohan Chintakuntla (1):
  arm64: Add boot time configuration of Intermediate Physical Address
    size

 arch/arm64/include/asm/kvm_arm.h       |   15 ++++++---------
 arch/arm64/include/asm/pgtable-hwdef.h |    5 ++---
 arch/arm64/kvm/hyp-init.S              |    7 +++++++
 arch/arm64/mm/proc.S                   |    9 ++++++++-
 4 files changed, 23 insertions(+), 13 deletions(-)
