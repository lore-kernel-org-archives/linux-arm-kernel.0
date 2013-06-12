From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 12 Jun 2013 10:23:27 -0700
Subject: [RFC 0/3] Allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM
Message-ID: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an RFC to allow CONFIG_DEBUG_SET_MODULE_RONX to be used on ARM. The
current config description from x86 describes it best:

	This option helps catch unintended modifications to loadable
	kernel module's text and read-only data. It also prevents execution
	of module data. Such protection may interfere with run-time code
	patching and dynamic kernel tracing - and they might also protect
	against certain classes of kernel exploits.

ARM was missing a few functions to modify the page tables so those have been
added. I believe modules are always mapped with pages so changing them at map
time should be acceptable. Comments/concerns are appreciated.

Thanks,
Laura

---

 arch/arm/Kconfig.debug            |   11 +++++
 arch/arm/include/asm/cacheflush.h |    5 ++
 arch/arm/include/asm/pgtable.h    |    2 +
 arch/arm/mm/mmu.c                 |   86 +++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 0 deletions(-)
