From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 21 May 2018 14:14:49 +0100
Subject: [PATCH 0/2] arm64: fatal kernel fault reporting improvements
Message-ID: <20180521131451.41040-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Catalin noticed that do_page_fault() can die() for some faults without
reporting the faulting address, which is unfortunate. We also don't
decode the ESR, or attempt to dump the page tables.

These patches unify the handling of those faults with the ones we handle
in __do_kernel_fault(), making things a little more consistent.

Thanks,
Mark.

Mark Rutland (2):
  arm64: make is_permission_fault() name clearer
  arm64: Unify kernel fault reporting

 arch/arm64/mm/fault.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

-- 
2.11.0
