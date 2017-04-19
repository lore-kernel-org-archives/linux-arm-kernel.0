From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 19 Apr 2017 23:39:44 +0200
Subject: [GIT PULL 00/16] clocksource: arm_arch_timer: GTDT-based MMIO
 timer support
In-Reply-To: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
References: <1492620273-30037-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170419213944.GC2523@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 05:44:17PM +0100, Mark Rutland wrote:
> Hi Daniel,
> 
> The series enables support for the MMIO architected timers (useful for
> system-level idle), which need to be probed via the GTDT when using ACPI. 
> 
> I realise this is a little late, but I would very much appreciate if you could
> pull these arch timer GTDT patches for v4.12. The series has been largely fine
> for a while now, and the major hold-ups were edge cases in error handling which
> have now been addressed.
> 
> The bulk of the series is a refactoring to cleanly separate the core driver, DT
> probe path, and ACPI probe path. The final patch of the series adds GTDT-based
> probing of the SBSA watchdog, using the new GTDT probing infrastructure. I've
> tested the patches on arm and arm64 platforms.
> 
> The ACPI parts have all been appropriately acked, and it's preferred that these
> all go through the clocksource tree.
> 
> The series is based on Marc's arch-timer-errata tag, which is alread in
> tip/timers/core.

Hi Thomas,

the series is ok for me. Is it possible to pull these changes directly in 
tip/timers/core?

There is a single trivial conflict with a trace.

  -- Daniel

> 
> The following changes since commit d003d029cea8a28139b4f9b88a36b8fac864f45b:
> 
>   arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI matching data (2017-04-07 11:22:10 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git tags/arch-timer-gtdt
> 
> for you to fetch changes up to ca9ae5ec4ef0ed13833b03297ab319676965492c:
> 
>   acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver (2017-04-19 17:00:15 +0100)
> 
> ----------------------------------------------------------------
> arch timer GTDT patches
> 
> - arch_timer cleanups and refactoring
> - new common GTDT parser
> - GTDT-based MMIO arch_timer support
> - GTDT-based SBSA watchdog support
> 
> ----------------------------------------------------------------
> Fu Wei (16):
>       clocksource: arm_arch_timer: clean up printk usage
>       clocksource: arm_arch_timer: rename type macros
>       clocksource: arm_arch_timer: rename the PPI enum
>       clocksource: arm_arch_timer: move enums and defines to header file
>       clocksource: arm_arch_timer: add a new enum for spi type
>       clocksource: arm_arch_timer: rework PPI selection
>       clocksource: arm_arch_timer: split dt-only rate handling
>       clocksource: arm_arch_timer: refactor arch_timer_needs_probing
>       clocksource: arm_arch_timer: move arch_timer_needs_of_probing into DT init call
>       clocksource: arm_arch_timer: add structs to describe MMIO timer
>       clocksource: arm_arch_timer: split MMIO timer probing.
>       acpi/arm64: Add GTDT table parse driver
>       clocksource: arm_arch_timer: simplify ACPI support code.
>       acpi/arm64: Add memory-mapped timer support in GTDT driver
>       clocksource: arm_arch_timer: add GTDT support for memory-mapped timer
>       acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
> 
>  arch/arm64/Kconfig                   |   1 +
>  drivers/acpi/arm64/Kconfig           |   3 +
>  drivers/acpi/arm64/Makefile          |   1 +
>  drivers/acpi/arm64/gtdt.c            | 417 +++++++++++++++++++++++++
>  drivers/clocksource/arm_arch_timer.c | 573 +++++++++++++++++++++++------------
>  include/clocksource/arm_arch_timer.h |  34 +++
>  include/linux/acpi.h                 |   7 +
>  7 files changed, 834 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/acpi/arm64/gtdt.c

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
