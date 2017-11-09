From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  9 Nov 2017 17:00:18 +0000
Subject: [PATCH v2 0/3] KVM: arm64: single step emulation instructions
Message-ID: <20171109170021.2984-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is rev 2 of the series. The main change is I've moved the helper
into it's own patch and changed it's return to a bool rather than try
and straddle the different return semantics of kvm_handle_mmio_return
and handle_exit.

The result is we no longer have code motion in patch 2 (now 3) to
introduce the helper making it embarrassingly short - but hopefully a
lot clearer.

As usual revision details bellow the --- in each patch.

Alex Benn?e (3):
  kvm: arm debug: introduce helper for single-step
  kvm: arm64: handle single-stepping trapped instructions
  kvm: arm64: handle single-step of userspace mmio instructions

 arch/arm/include/asm/kvm_host.h   |  2 ++
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++
 arch/arm64/kvm/handle_exit.c      | 47 +++++++++++++++++++++++++++------------
 virt/kvm/arm/arm.c                |  3 +++
 5 files changed, 61 insertions(+), 14 deletions(-)

-- 
2.14.2
