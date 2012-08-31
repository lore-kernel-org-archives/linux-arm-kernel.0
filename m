From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 31 Aug 2012 20:24:51 +0530
Subject: Without MACH_ option Early printk (DEBUG_LL)
Message-ID: <5040D03B.2050304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell & Tony,

AM335X EVM (based on AM33XX device) only supports DT boot mode and
doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
baseport submission we had aligned that, we won't create separate EVM
options, killing the board file all-together.

Having said that, the early printk option (DEBUG_LL) is broken, the
auto-generated file "./include/generated/mach-types.h" still refers to
CONFIG_MACH_AM335XEVM option,

#ifdef CONFIG_MACH_AM335XEVM
# ifdef machine_arch_type
#  undef machine_arch_type
#  define machine_arch_type     __machine_arch_type
# else
#  define machine_arch_type     MACH_TYPE_AM335XEVM
# endif
# define machine_is_am335xevm() (machine_arch_type == MACH_TYPE_AM335XEVM)
#else
# define machine_is_am335xevm() (0)
#endif


So I am thinking of changing the config_xxx option to SOC_AM33XX or
ARCH_OMAP2PLUS, something like below,

am335xevm        SOC_AM33XX          AM335XEVM         3589

OR

am335xevm        ARCH_OMAP2PLUS      AM335XEVM         3589


Can you comment on this? Based on that I will submit the patch.

Thanks,
Vaibhav
