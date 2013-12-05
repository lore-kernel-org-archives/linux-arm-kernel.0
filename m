From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 21:25:57 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
Message-ID: <201312052125.57644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 December 2013, Rob Herring wrote:
> select ARM_AMBA
> select ARM_GIC if CPU_V7
> select HAVE_SMP if CPU_V7
> select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
> select ARCH_HAS_CPUFREQ
> select ARCH_HAS_OPP

Not sure about ARM_GIC and HAVE_SMP, as they won't typically be
set on Cortex-A8, Scorpion and PJ4. The other suggestions sound
good, and your patch looks fine as well.

Acked-by: Arnd Bergmann <arnd@arndb.de>
