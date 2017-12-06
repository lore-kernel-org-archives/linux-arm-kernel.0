From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  6 Dec 2017 16:45:44 +0000
Subject: [PATCH v2 0/3] arm64: SVE fixes for v4.15-rc2
Message-ID: <1512578747-4554-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains a few fixes for known issues in the arm64 FPSIMD
and SVE implementation.

This supersedes the previous posting. [1]

Note that although patch 2 is not a fix, it provides refactoring that is
used by the fix in patch 3.

[1] [PATCH 0/3] arm64: SVE fixes for v4.15-rc1
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545126.html

Dave Martin (3):
  arm64: fpsimd: Prevent registers leaking from dead tasks
  arm64: fpsimd: Abstract out binding of task's fpsimd context to the
    cpu.
  arm64/sve: Avoid dereference of dead task_struct in KVM guest entry

 arch/arm64/kernel/fpsimd.c  | 51 ++++++++++++++++++++++++++-------------------
 arch/arm64/kernel/process.c |  9 ++++++++
 2 files changed, 39 insertions(+), 21 deletions(-)

-- 
2.1.4
