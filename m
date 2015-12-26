From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Sat, 26 Dec 2015 17:23:51 +0900
Subject: v4.3-rc1 or later kernels fail to boot the Mustang board
Message-ID: <567E4E97.7040209@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
After this commit between the tags v4.2 and v4.3-rc1,

commit 752240e74d650faa24425adc523f1308973ea51c
Merge: b8cb642 626d750
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Sep 8 11:46:48 2015 -0700

     Merge tag 'for-linus-4.3-rc0-tag' of 
git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip

     Pull xen updates from David Vrabel:
      "Xen features and fixes for 4.3:

        - Convert xen-blkfront to the multiqueue API
        - [arm] Support binding event channels to different VCPUs.
        - [x86] Support > 512 GiB in a PV guests (off by default as such a
          guest cannot be migrated with the current toolstack).
        - [x86] PMU support for PV dom0 (limited support for using perf with
          Xen and other guests)"

     * tag 'for-linus-4.3-rc0-tag' of 
git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip: (33 commits)
       xen: switch extra memory accounting to use pfns
       xen: limit memory to architectural maximum
       xen: avoid another early crash of memory limited dom0
       xen: avoid early crash of memory limited dom0
       arm/xen: Remove helpers which are PV specific
       xen/x86: Don't try to set PCE bit in CR4
       xen/PMU: PMU emulation code
       xen/PMU: Intercept PMU-related MSR and APIC accesses
       xen/PMU: Describe vendor-specific PMU registers
       xen/PMU: Initialization code for Xen PMU
       xen/PMU: Sysfs interface for setting Xen PMU mode
       xen: xensyms support
       xen: remove no longer needed p2m.h
       xen: allow more than 512 GB of RAM for 64 bit pv-domains
       xen: move p2m list if conflicting with e820 map
       xen: add explicit memblock_reserve() calls for special pages
       mm: provide early_memremap_ro to establish read-only mapping
       xen: check for initrd conflicting with e820 map
       xen: check pre-allocated page tables for conflict with memory map
       xen: check for kernel memory conflicting with memory layout
       ...

Kernels fail to boot the Mustang board which I have access. Do I need a 
newer F/W so I can
use recent, v4.4-rcX mainline kernels?
