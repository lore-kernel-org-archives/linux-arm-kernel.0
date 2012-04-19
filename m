From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 12:55:39 +0000
Subject: [PATCH v3 4/6] ARM: architected timers: add DT support
In-Reply-To: <1334592810-4382-5-git-send-email-marc.zyngier@arm.com>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
 <1334592810-4382-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <201204191255.39952.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 April 2012, Marc Zyngier wrote:
> Add runtime DT support and documentation for the Cortex A7/A15
> architected timers.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../devicetree/bindings/arm/arch_timer.txt         |   27 ++++++++++
>  arch/arm/include/asm/arch_timer.h                  |    6 ++
>  arch/arm/kernel/arch_timer.c                       |   53 +++++++++++++++++---
>  3 files changed, 79 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
> 

This looks good, but do we actually still need the non-DT case?

Both vexpress and exynos5 allow booting through DT and we are not
planning to add any new platforms with these timers that don't.

	Arnd
