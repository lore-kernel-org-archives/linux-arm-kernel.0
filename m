From: jeyu@redhat.com (Jessica Yu)
Date: Tue, 7 Feb 2017 11:25:05 -0800
Subject: arch: Rename CONFIG_DEBUG_RODATA and CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <1486427518-14819-3-git-send-email-labbott@redhat.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com>
Message-ID: <20170207192505.m5gg6rtqgbbwtwa4@jeyu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Laura Abbott [06/02/17 16:31 -0800]:
>Both of these options are poorly named. The features they provide are
>necessary for system security and should not be considered debug only.
>Change the names to CONFIG_STRICT_KERNEL_RWX and
>CONFIG_STRICT_MODULE_RWX to better describe what these options do.
>
>Signed-off-by: Laura Abbott <labbott@redhat.com>
>---
>v3: Minor config text tweek per Kees. Corrected the change of config names in
>the arm config files.
>---
> Documentation/DocBook/kgdb.tmpl            | 8 ++++----
> Documentation/security/self-protection.txt | 4 ++--
> arch/Kconfig                               | 4 ++--
> arch/arm/configs/aspeed_g4_defconfig       | 4 ++--
> arch/arm/configs/aspeed_g5_defconfig       | 4 ++--
> arch/arm/include/asm/cacheflush.h          | 2 +-
> arch/arm/kernel/patch.c                    | 4 ++--
> arch/arm/kernel/vmlinux.lds.S              | 8 ++++----
> arch/arm/mm/Kconfig                        | 2 +-
> arch/arm/mm/init.c                         | 4 ++--
> arch/arm64/Kconfig.debug                   | 2 +-
> arch/arm64/kernel/insn.c                   | 2 +-
> arch/parisc/configs/712_defconfig          | 1 -
> arch/parisc/configs/c3000_defconfig        | 1 -
> arch/parisc/mm/init.c                      | 2 +-
> include/linux/filter.h                     | 4 ++--
> include/linux/init.h                       | 4 ++--
> include/linux/module.h                     | 2 +-
> init/main.c                                | 4 ++--
> kernel/configs/android-recommended.config  | 2 +-
> kernel/module.c                            | 6 +++---
> kernel/power/hibernate.c                   | 2 +-
> kernel/power/power.h                       | 4 ++--
> kernel/power/snapshot.c                    | 4 ++--
> 24 files changed, 41 insertions(+), 43 deletions(-)

For the module.{c,h} bits:

Acked-by: Jessica Yu <jeyu@redhat.com>
