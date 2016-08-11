From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 14:11:04 +0100
Subject: [PATCHv2 0/2] arm64: hibernate: a couple of fixes
Message-ID: <1470921066-27421-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches fix a couple of issues I spotted in the arm64 hibernate code.

Patch 1 addresses potential Break-Before-Make violations, and patch 2 addresses
failure cases where TTBR0 may be left pointing at memory which has been freed.

I've given the kernel a go with these patches applied, and I do not see any
regressions in hibernation functionality.

Thanks,
Mark.

Since v1 [1]:
* s/suspend/hibernate/ in patch 1 title
* Use cpu_set_reserved_ttbr0() to safely handle userspace hibernation testing
* Add patch to safely handle allocation failures

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447392.html

Mark Rutland (2):
  arm64: hibernate: avoid potential TLB conflict
  arm64: hibernate: handle allocation failures

 arch/arm64/kernel/hibernate.c | 82 ++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 33 deletions(-)

-- 
1.9.1
