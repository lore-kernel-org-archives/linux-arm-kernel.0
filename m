From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:17:39 -0700
Subject: [PATCH v3 0/3] of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
Message-ID: <20181025001742.6510-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Based on Rob's suggestion, this is a follow-up to the patch series
posted here previously that aims at cutting the ARM64 rebuild
time/number of objects. Rob indicated that he was adamant to just having
drivers/of/fdt.c contain the ARM64 specific behavior, so this patch
series does exactly that.

https://www.spinics.net/lists/devicetree/msg255512.html

Florian Fainelli (3):
  of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
  arm64: Remove custom __early_init_dt_declare_initrd implenentation
  of/fdt: Remove definition check for __early_init_dt_declare_initrd

 arch/arm64/include/asm/memory.h | 8 --------
 drivers/of/fdt.c                | 7 +++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.17.1
