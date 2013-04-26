From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Fri, 26 Apr 2013 16:34:54 +0530
Subject: [PATCH 0/2] Early printk support for virtio console devices.
Message-ID: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set implements early printk support for virtio console devices without using any hypercalls.

The current virtio early printk code in kernel expects that hypervisor will provide some mechanism generally a hypercall to support early printk. This patch-set does not break existing hypercall based early print support.

This implementation adds:
1. Early writeonly register named early_wr in virtio console's config space.
2. Host feature flags namely VIRTIO_CONSOLE_F_EARLY_WRITE for telling guest about early-write capability in console device.

Early write mechanism:
1. When a guest wants to out some character, it has to simply write the character to early_wr register in config space of virtio console device.

Pranavkumar Sawargaonkar (2):
  virtio: console: Add early writeonly register to config space
  arm64: earlyprintk support for virtio-mmio console

 Documentation/virtual/virtio-spec.txt |   13 ++++++++++--
 arch/arm64/kernel/early_printk.c      |   35 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_console.h   |    3 +++
 3 files changed, 49 insertions(+), 2 deletions(-)

-- 
1.7.9.5
