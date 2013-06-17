From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 17 Jun 2013 10:29:11 -0700
Subject: [PATCH v2 0/3] Allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM
Message-ID: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a series to allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM. The
current config description from x86 describes it best:

	This option helps catch unintended modifications to loadable
	kernel module's text and read-only data. It also prevents execution
	of module data. Such protection may interfere with run-time code
	patching and dynamic kernel tracing - and they might also protect
	against certain classes of kernel exploits.

v2: Add module bounds checking per Russell, removed dsb per Catalin.
Macrofied the set_memory_* functions to avoid so much code duplication.

Thanks,
Laura

---

 arch/arm/Kconfig.debug            |   11 ++++++++++
 arch/arm/include/asm/cacheflush.h |    5 ++++
 arch/arm/include/asm/pgtable.h    |    2 +
 arch/arm/mm/mmu.c                 |   38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 0 deletions(-)
