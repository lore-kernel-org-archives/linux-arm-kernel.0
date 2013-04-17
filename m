From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 17 Apr 2013 18:41:46 +0100
Subject: [PATCH v11 0/3] Another round of ARMv7-M patches
In-Reply-To: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <516EDEDA.1000108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Nice! I'd love to see these in mainline and they look good now...

On 17/04/13 17:14, Uwe Kleine-K?nig wrote:
> Hello,
>
> the changes since v10 are small:
>
>   - Jonny noticed an inconsitency in arch/arm/mm/proc-v7m.S
>   - changes to account for review comments to my nvic driver (v3 just
>     sent out)
>
> I put these three patches in my for-next branch so they should make it
> into the next next. The tree merges fine into current Linus' master and
> next-20130417.
>

The only comment I have left is that I'd really like the 
BASEADDRESS_V7M_SCB namespaced like the rest of the V7M defines

With that said, please feel free to add for the series:

Reviewed-by: Jonathan Austin <jonathan.austin@arm.com>
Tested-by: Jonathan Austin <jonathan.austin@arm.com

Jonny

> Russell, what are your thoughts about the series? Would you take it for
> v3.10? Or v3.11?
>
> Catalin Marinas (1):
>    ARM: Add base support for ARMv7-M
>
> Uwe Kleine-K?nig (2):
>    ARM: ARMv7-M: Add support for exception handling
>    ARM: ARMv7-M: Allow the building of new kernel port
>
>   arch/arm/Kconfig                   |   4 +-
>   arch/arm/Kconfig-nommu             |   2 +-
>   arch/arm/Makefile                  |   1 +
>   arch/arm/include/asm/assembler.h   |  17 +++-
>   arch/arm/include/asm/cputype.h     |  12 ++-
>   arch/arm/include/asm/glue-cache.h  |  27 +++++++
>   arch/arm/include/asm/glue-df.h     |   8 ++
>   arch/arm/include/asm/glue-proc.h   |   9 +++
>   arch/arm/include/asm/irqflags.h    |  22 ++++--
>   arch/arm/include/asm/ptrace.h      |   4 +
>   arch/arm/include/asm/system_info.h |   1 +
>   arch/arm/include/asm/v7m.h         |  44 +++++++++++
>   arch/arm/include/uapi/asm/ptrace.h |  35 +++++++--
>   arch/arm/kernel/Makefile           |   8 +-
>   arch/arm/kernel/entry-common.S     |   4 +
>   arch/arm/kernel/entry-header.S     | 124 +++++++++++++++++++++++++++++
>   arch/arm/kernel/entry-v7m.S        | 143 +++++++++++++++++++++++++++++++++
>   arch/arm/kernel/head-nommu.S       |  10 ++-
>   arch/arm/kernel/setup.c            |  17 +++-
>   arch/arm/kernel/traps.c            |   8 ++
>   arch/arm/mm/Kconfig                |  21 ++++-
>   arch/arm/mm/Makefile               |   2 +
>   arch/arm/mm/cache-nop.S            |  50 ++++++++++++
>   arch/arm/mm/nommu.c                |   7 ++
>   arch/arm/mm/proc-v7m.S             | 157 +++++++++++++++++++++++++++++++++++++
>   25 files changed, 711 insertions(+), 26 deletions(-)
>   create mode 100644 arch/arm/include/asm/v7m.h
>   create mode 100644 arch/arm/kernel/entry-v7m.S
>   create mode 100644 arch/arm/mm/cache-nop.S
>   create mode 100644 arch/arm/mm/proc-v7m.S
>
