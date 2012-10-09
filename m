From: dhowells@redhat.com (David Howells)
Date: Tue, 09 Oct 2012 10:15:13 +0100
Subject: [GIT PULL] Disintegrate UAPI for arm64 [ver #2]
Message-ID: <21110.1349774113@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can you merge the following branch into the arm64 tree please.

This is to complete part of the UAPI disintegration for which the preparatory
patches were pulled recently.

Now that the fixups and the asm-generic chunk have been merged, I've
regenerated the patches to get rid of those dependencies and to take account of
any changes made so far in the merge window.  If you have already pulled the
older version of the branch aimed at you, then please feel free to ignore this
request.

The following changes since commit 9e2d8656f5e8aa214e66b462680cf86b210b74a8:

  Merge branch 'akpm' (Andrew's patch-bomb) (2012-10-09 16:23:15 +0900)

are available in the git repository at:


  git://git.infradead.org/users/dhowells/linux-headers.git tags/disintegrate-arm64-20121009

for you to fetch changes up to a24b2da6de9a44f395c67219d300de21f66d0da3:

  UAPI: (Scripted) Disintegrate arch/arm64/include/asm (2012-10-09 09:46:34 +0100)

----------------------------------------------------------------
UAPI Disintegration 2012-10-09

----------------------------------------------------------------
David Howells (1):
      UAPI: (Scripted) Disintegrate arch/arm64/include/asm

 arch/arm64/include/asm/Kbuild                   |   2 -
 arch/arm64/include/asm/hwcap.h                  |  22 +----
 arch/arm64/include/asm/ptrace.h                 |  88 +------------------
 arch/arm64/include/asm/sigcontext.h             |  40 +--------
 arch/arm64/include/asm/stat.h                   |   5 +-
 arch/arm64/include/asm/unistd.h                 |   8 +-
 arch/arm64/include/uapi/asm/Kbuild              |  14 +++
 arch/arm64/include/{ => uapi}/asm/auxvec.h      |   0
 arch/arm64/include/{ => uapi}/asm/bitsperlong.h |   0
 arch/arm64/include/{ => uapi}/asm/byteorder.h   |   0
 arch/arm64/include/{ => uapi}/asm/fcntl.h       |   0
 arch/arm64/include/uapi/asm/hwcap.h             |  39 +++++++++
 arch/arm64/include/{ => uapi}/asm/param.h       |   0
 arch/arm64/include/uapi/asm/ptrace.h            | 110 ++++++++++++++++++++++++
 arch/arm64/include/{ => uapi}/asm/setup.h       |   0
 arch/arm64/include/uapi/asm/sigcontext.h        |  57 ++++++++++++
 arch/arm64/include/{ => uapi}/asm/siginfo.h     |   0
 arch/arm64/include/{ => uapi}/asm/signal.h      |   0
 arch/arm64/include/uapi/asm/stat.h              |  16 ++++
 arch/arm64/include/{ => uapi}/asm/statfs.h      |   0
 arch/arm64/include/uapi/asm/unistd.h            |  16 ++++
 21 files changed, 257 insertions(+), 160 deletions(-)
 rename arch/arm64/include/{ => uapi}/asm/auxvec.h (100%)
 rename arch/arm64/include/{ => uapi}/asm/bitsperlong.h (100%)
 rename arch/arm64/include/{ => uapi}/asm/byteorder.h (100%)
 rename arch/arm64/include/{ => uapi}/asm/fcntl.h (100%)
 create mode 100644 arch/arm64/include/uapi/asm/hwcap.h
 rename arch/arm64/include/{ => uapi}/asm/param.h (100%)
 create mode 100644 arch/arm64/include/uapi/asm/ptrace.h
 rename arch/arm64/include/{ => uapi}/asm/setup.h (100%)
 create mode 100644 arch/arm64/include/uapi/asm/sigcontext.h
 rename arch/arm64/include/{ => uapi}/asm/siginfo.h (100%)
 rename arch/arm64/include/{ => uapi}/asm/signal.h (100%)
 create mode 100644 arch/arm64/include/uapi/asm/stat.h
 rename arch/arm64/include/{ => uapi}/asm/statfs.h (100%)
 create mode 100644 arch/arm64/include/uapi/asm/unistd.h
.
