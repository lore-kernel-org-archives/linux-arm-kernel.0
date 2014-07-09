From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Jul 2014 19:22:10 +0100
Subject: [PATCH 0/3] Bunch of vdso cleanups following feedback from x86
Message-ID: <1404930133-30324-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Following useful discussions with Andy (thanks!), I've put together the
following (lightly tested) series for arm64 which attempts to address
issues with our current vdso code.

Please take a look. Cheers,

Will

--->8

Will Deacon (3):
  arm64: vdso: put vdso datapage in a separate vma
  arm64: vdso: move to _install_special_mapping and remove arch_vma_name
  arm64: vdso: move data page before code pages

 arch/arm64/kernel/vdso.c          | 94 +++++++++++++++++++++------------------
 arch/arm64/kernel/vdso/vdso.lds.S |  4 +-
 2 files changed, 52 insertions(+), 46 deletions(-)

-- 
2.0.0
