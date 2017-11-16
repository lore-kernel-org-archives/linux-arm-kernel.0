From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 16 Nov 2017 15:39:18 +0000
Subject: [PATCH v3 0/3] KVM: arm64: single step emulation instructions
Message-ID: <20171116153921.21991-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is rev 3 of the series, practically the same than rev 2 but fixed
a return 1->0 in the kvm_run loop that Julien caught. I've added his
r-b tags to the other patches.

As usual revision details bellow the --- in each patch.

Alex Benn?e (3):
  kvm: arm debug: introduce helper for single-step
  kvm: arm64: handle single-stepping trapped instructions
  kvm: arm64: handle single-step of userspace mmio instructions

 arch/arm/include/asm/kvm_host.h   |  5 +++++
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++
 arch/arm64/kvm/handle_exit.c      | 47 +++++++++++++++++++++++++++------------
 virt/kvm/arm/arm.c                |  3 +++
 5 files changed, 64 insertions(+), 14 deletions(-)

-- 
2.15.0
