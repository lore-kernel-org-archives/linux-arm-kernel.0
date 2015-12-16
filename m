From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 16 Dec 2015 17:08:04 +0000
Subject: [PATCH 0/2] Fix NMI backtrace for Inforce IFC6410
Message-ID: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After spotting some problems with the SysRq-L on Inforce IFC6410 I ran
some tests (see patch 2) and concluded that certain SGI IDs cannot be
used by Linux on these platforms because they have been reserved for use
by the secure world.

This patchset includes both a patch to resolve the problem on Inforce
IFC6410 and a patch to detect and report reserved SGI IDs during boot.
The patch (deliberately) keeps quiet on platforms where the kernel's
world is not subject to any restrictions.


Daniel Thompson (2):
  arm: Fix "NMI" backtrace for Inforce IFC6410
  irqchip/gic: Identify and report any reserved SGI IDs

 arch/arm/kernel/smp.c     |  3 ++-
 drivers/irqchip/irq-gic.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

--
2.5.0
