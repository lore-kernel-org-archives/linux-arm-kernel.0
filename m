From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu, 11 May 2017 13:46:10 +0100
Subject: [PATCH v2 0/2] plug KVM ARMv7 debug leakage
Message-ID: <20170511124612.11212-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is pretty much v1 + comments from Marc and a minor re-factor of
the trap path to make it cleaner w.r.t. cp14/cp15 trapping.

Zhichao Huang (2):
  KVM: arm: plug potential guest hardware debug leakage
  KVM: arm: rename pm_fake handler to trap_raz_wi

 arch/arm/include/asm/kvm_coproc.h |   3 +-
 arch/arm/kvm/coproc.c             | 105 ++++++++++++++++++++++++++------------
 arch/arm/kvm/handle_exit.c        |   4 +-
 arch/arm/kvm/hyp/switch.c         |   4 +-
 4 files changed, 80 insertions(+), 36 deletions(-)

-- 
2.11.0
