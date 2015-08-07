From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Aug 2015 15:34:44 +0200
Subject: [PATCH 0/2] ARM: Wire up userfaultfd and mlock2 syscalls
Message-ID: <1438954486-28286-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These are two fairly trivial patches to wire up the userfaultfd and
mlock2 syscalls on 32-bit ARM. I've verified that these work by running
the userfaultfd and mlock2-tests tests from tools/testing/selftests/vm/
and they give good results. Note that mlock2-tests doesn't work without
additional fixups in linux-next needed to remove VM flags clashes.

I suppose this would have to wait until both of the above syscalls have
actually been merged, but I figured I'd post them anyway since I already
did the work and verified that they work.

Thierry

Thierry Reding (2):
  ARM: Wire up userfaultfd syscall
  ARM: Wire up mlock2 syscall

 arch/arm/include/asm/unistd.h      | 2 +-
 arch/arm/include/uapi/asm/unistd.h | 2 ++
 arch/arm/kernel/calls.S            | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.4.5
