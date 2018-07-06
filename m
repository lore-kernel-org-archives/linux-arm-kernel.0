From: labbott@redhat.com (Laura Abbott)
Date: Thu,  5 Jul 2018 17:49:36 -0700
Subject: [PATCHv6 0/4] Salted build ids via ELF notes
Message-ID: <20180706004940.32587-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v6 of the series to allow unique build ids. v6 is mostly minor
fixups and Acks for this to go through the kbuild tree.

Thanks,
Laura

Laura Abbott (4):
  kbuild: Add build salt to the kernel and modules
  x86: Add build salt to the vDSO
  powerpc: Add build salt to the vDSO
  arm64: Add build salt to the vDSO

 arch/arm64/kernel/vdso/note.S     |  3 +++
 arch/powerpc/kernel/vdso32/note.S |  3 +++
 arch/x86/entry/vdso/vdso-note.S   |  3 +++
 arch/x86/entry/vdso/vdso32/note.S |  3 +++
 include/linux/build-salt.h        | 20 ++++++++++++++++++++
 init/Kconfig                      |  9 +++++++++
 init/version.c                    |  3 +++
 scripts/mod/modpost.c             |  3 +++
 8 files changed, 47 insertions(+)
 create mode 100644 include/linux/build-salt.h

-- 
2.17.1
