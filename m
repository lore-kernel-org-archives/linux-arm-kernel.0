From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 22 Jun 2010 09:59:09 +0300
Subject: [PATCH 0/3] makedumpfile: add support for ARM crashdumps
Message-ID: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for ARM kernel crashdumps to makedumpfile. Although,
kernel support is not yet in mainline, I think that it doesn't hurt to have
necessary userspace tools available when that happens.

If someone wants to try, kernel patches can be found:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014230.html

and kexec-tools already contain ARM crashdump support.

Regards,
MW

Mika Westerberg (3):
  use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations
  page_to_pfn(): use ULONGLONG_MAX to for invalid pfn
  add ARM crashdump support

 Makefile       |    4 +-
 arm.c          |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    7 +-
 makedumpfile.h |   43 ++++++++++++-
 4 files changed, 247 insertions(+), 7 deletions(-)
 create mode 100644 arm.c
