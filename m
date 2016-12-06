From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  6 Dec 2016 11:53:09 -0800
Subject: [PATCH 0/3] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <1480445729-27130-1-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
Message-ID: <20161206195312.22354-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series builds on top of Laura's [PATCHv4 00/10] CONFIG_DEBUG_VIRTUAL for arm64
to add support for CONFIG_DEBUG_VIRTUAL for ARM.

This was tested on a Brahma B15 platform (ARMv7 + HIGHMEM + LPAE).

There are a number of possible follow up/cleanup patches:

- all SMP implements that pass down the address of secondary_startup to the SMP bringup
  operations should use __pa_symbol() instead since they reference in-kernel symbols

Flames, critiques, rotten tomatoes welcome!

Florian Fainelli (3):
  ARM: Define KERNEL_START and KERNEL_END
  ARM: Utilize __pa_symbol in lieu of __pa
  ARM: Add support for CONFIG_DEBUG_VIRTUAL

 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/memory.h | 23 +++++++++++++++++--
 arch/arm/mm/Makefile          |  1 +
 arch/arm/mm/init.c            |  7 ++----
 arch/arm/mm/mmu.c             | 10 +++------
 arch/arm/mm/physaddr.c        | 51 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mm/physaddr.c

-- 
2.9.3
