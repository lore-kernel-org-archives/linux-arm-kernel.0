From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 25 May 2010 07:45:43 +0200
Subject: [PATCH] ARM: S5P: Fix the platform external interrupt issues.
In-Reply-To: <1274687063-748-1-git-send-email-kgene.kim@samsung.com>
References: <1274687063-748-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <019e01cafbcd$8640c6a0$92c253e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, May 24, 2010 9:44 AM Kukjin Kim wrote:

> From: Pannaga Bhushan <p.bhushan@samsung.com>
> 
> This patch does the following:
> 
> 1. Corrects the common platform code for external interrupts for using the
>    VIC mask/unmask bits also.
> 2. Moves the common defines related to external interrupt for plat-s5p
>    to common files.
> 3. Based on the new common defines, corresponding changes are made in the
>    affected platforms (S5P6440, S5P6442 and S5PC100).
> 
> Signed-off-by: Pannaga Bhushan <p.bhushan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5p6440/include/mach/irqs.h      |    9 ++++++++-
>  arch/arm/mach-s5p6442/include/mach/irqs.h      |    5 +++--
>  arch/arm/mach-s5pc100/include/mach/irqs.h      |    3 ---
>  arch/arm/mach-s5pv210/include/mach/irqs.h      |   14 ++------------
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   14 +++++++++-----
>  arch/arm/plat-s5p/Kconfig                      |    1 +
>  arch/arm/plat-s5p/include/plat/irqs.h          |    7 +++++++
>  arch/arm/plat-s5p/irq-eint.c                   |   15 ++++++++++-----
>  8 files changed, 40 insertions(+), 28 deletions(-)

This patch lacks a fix for arch/arm/mach-s5pc100/include/mach/regs-gpio.h
file. It should revert the changes from commit 45c79433c02b8fe7b8a1cbf6054
to that file. Without it the external interrupt 16..31 does not work on
S5PC100.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
