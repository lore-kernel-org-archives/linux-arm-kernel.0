From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Dec 2013 18:31:12 +0000
Subject: [PATCH 0/2] kvmtool: Enable overriding Generic Timer frequency
Message-ID: <1387305074-29421-1-git-send-email-robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allows (but discourages) overriding the Generic Timer
frequency for device tree-based guest OSes, to work around systems with
broken secure firmware that fails to program CNTFRQ correctly.

Robin Murphy (2):
  kvmtool: Support unsigned int options
  kvmtool/arm: Add option to override Generic Timer frequency

 tools/kvm/arm/include/arm-common/kvm-config-arch.h |   15 ++++++++++-----
 tools/kvm/arm/timer.c                              |    2 ++
 tools/kvm/include/kvm/parse-options.h              |    9 +++++++++
 3 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.7.9.5
