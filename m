From: avienamo@nvidia.com (Aapo Vienamo)
Date: Wed, 5 Aug 2015 18:50:31 +0300
Subject: [BUG] arm: kgdb: patch_text() in kgdb_arch_set_breakpoint() may sleep
Message-ID: <55C230C7.2000909@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The breakpoint setting code in arch/arm/kernel/kgdb.c calls
patch_text(), which ends up trying to sleep while in interrupt context.
The bug was introduced by commit: 23a4e40 arm: kgdb: Handle read-only
text / modules. The resulting behavior is "BUG: scheduling while
atomic..." when setting a breakpoint in kgdb. This was tested on an
Nvidia Jetson TK1 board with 4.2.0-rc5-next-20150805 kernel.

Regards,
Aapo Vienamo
