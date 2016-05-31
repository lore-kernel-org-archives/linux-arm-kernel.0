From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 14:49:00 +0100
Subject: [PATCH 0/2] arm64: mm: dump: rework and fix
Message-ID: <1464702542-24394-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Here are a couple of patches for the arm64 pagetable dump code.

The first patch is the final reusable ptdump patch, rebased to v4.7-rc1, as per
your request [1]. Other than the rebase, I have made no changes.

The second patch addresses an ambiguity in the dump output, in that we cannot
determine whether a span of block entries exists at the PGD, PUD, or PMD level.
It's logically unrelated to patch 1, and the two should apply independently,
but I've put them in a series so that I can call that out, and to avoid the
inevitable confusion with patches that appear to intersect.

I've given them both a spin on Juno R1 with v4.7-rc1 defconfig, fiddling with
the page size and number of levels. So far everything seems to work as
expected.

Thanks,
Mark.

[1] http://lkml.kernel.org/r/20160531132508.GJ24936 at arm.com

Mark Rutland (2):
  arm64: mm: dump: make page table dumping reusable
  arm64: mm: dump: log span level

 arch/arm64/include/asm/ptdump.h | 44 +++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/dump.c            | 40 +++++++++++++++++++++++++------------
 2 files changed, 71 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/include/asm/ptdump.h

-- 
1.9.1
