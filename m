From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 09 Mar 2011 00:21:51 +0000
Subject: [PATCH 0/5] Fix build failures with binutils 2.21
Message-ID: <1299630111.4146.15.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gas has been silently ignoring .size directives with typos, but this was
fixed in binutils 2.21, resulting in build failures with the new
version.

I collected a couple of fixes for x86, then saw a similar failure on
sparc and went hunting for more instances.  This series, based on
2.6.38-rc8, should cover them all.  However, my changes are not even
build-tested.

Ben.

Alan Modra (1):
  x86: Fix .size directive for async_page_fault

Ben Hutchings (3):
  sparc: Fix .size directive for do_int_load
  avr32: Fix .size directive for cpu_enter_idle
  arm: Fix .size directives for __arm{7,9}tdmi_proc_info

H.J. Lu (1):
  x86: Fix .size directive for xen_do_hypervisor_callback

 arch/arm/mm/proc-arm7tdmi.S            |    2 +-
 arch/arm/mm/proc-arm9tdmi.S            |    2 +-
 arch/avr32/mach-at32ap/pm-at32ap700x.S |    2 +-
 arch/sparc/kernel/una_asm_64.S         |    2 +-
 arch/x86/kernel/entry_32.S             |    2 +-
 arch/x86/kernel/entry_64.S             |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.4.1


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110309/ba24a4fd/attachment-0001.sig>
