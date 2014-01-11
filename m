From: juergen@kreuzholzen.de (Juergen Beisert)
Date: Sat, 11 Jan 2014 22:20:48 +0100
Subject: Mini6410 build fails with confusing CONFIG parameters
Message-ID: <201401112220.48693.juergen@kreuzholzen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

with PM_GENERIC_DOMAINS=y and CONFIG_PM=N

[...]
  CC      drivers/base/power/domain.o
drivers/base/power/domain.c: In function '__pm_genpd_add_device':
drivers/base/power/domain.c:1422:2: error: implicit declaration of function 'genpd_acquire_lock' [-Werror=implicit-function-declaration]
drivers/base/power/domain.c:1466:2: error: implicit declaration of function 'genpd_release_lock' [-Werror=implicit-function-declaration]
drivers/base/power/domain.c: In function 'pm_genpd_add_subdomain':
drivers/base/power/domain.c:1649:3: error: implicit declaration of function 'genpd_sd_counter_inc' [-Werror=implicit-function-declaration]
drivers/base/power/domain.c: In function 'pm_genpd_remove_subdomain':
drivers/base/power/domain.c:1721:4: error: implicit declaration of function 'genpd_sd_counter_dec' [-Werror=implicit-function-declaration]
drivers/base/power/domain.c: In function 'pm_genpd_attach_cpuidle':
drivers/base/power/domain.c:1887:2: error: implicit declaration of function 'genpd_recalc_cpu_exit_latency' [-Werror=implicit-function-declaration]

How can this happen?

Symbol: PM_GENERIC_DOMAINS [=y]
    Type  : boolean
      Defined at kernel/power/Kconfig:277
      Depends on: PM [=n]
      Selected by: ARCH_SHMOBILE [=n] && <choice> && PM [=n] || ARCH_S3C64XX [=y] && <choice> || CPU [...]

Shouldn't PM_GENERIC_DOMAINS be forced to "n", because it depends on PM?

jbe
