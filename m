From: adrienverge@gmail.com (=?UTF-8?Q?Adrien_Verg=C3=A9?=)
Date: Tue, 3 Dec 2013 23:37:58 -0500
Subject: ARM Coresight: Enhance ETM tracing control
Message-ID: <CANsc=4X_C53AHe5p5sRiHDGPA0+P4NgtGWrhOe0h27MZ9LwWbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usage of ETM tracing facility is currently very limited: user can
only start/stop tracing. This set of patches enables management of
address combinations and PIDs that trigger tracing.

ETM management was done via sysfs entries (trace_info,
trace_running...), this code adds trace_addrrange and trace_pid to
let the user read/write custom values.

This series of patches apply to v3.13-rc2.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
Adrien Verg? (3):
  ARM Coresight: Rename 'comparator' to 'address comparator' in ETM
  ARM Coresight: Add address control support for ETM tracing
  ARM Coresight: Add PID control support for ETM tracing

 arch/arm/Kconfig.debug                    |   1 +
 arch/arm/include/asm/hardware/coresight.h |   7 +-
 arch/arm/kernel/etm.c                     | 139 ++++++++++++++++++++++++++----
 3 files changed, 129 insertions(+), 18 deletions(-)

-- 
1.8.3.1
