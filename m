From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Aug 2012 18:13:36 +0100
Subject: Without MACH_ option Early printk (DEBUG_LL)
In-Reply-To: <5040D03B.2050304@ti.com>
References: <5040D03B.2050304@ti.com>
Message-ID: <20120831171336.GA6978@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 08:24:51PM +0530, Vaibhav Hiremath wrote:
> Hi Russell & Tony,
> 
> AM335X EVM (based on AM33XX device) only supports DT boot mode and
> doesn't have CONFIG_MACH_AM335XEVM option defined. Some time back during
> baseport submission we had aligned that, we won't create separate EVM
> options, killing the board file all-together.
> 
> Having said that, the early printk option (DEBUG_LL) is broken, the
> auto-generated file "./include/generated/mach-types.h" still refers to
> CONFIG_MACH_AM335XEVM option,
> 
> #ifdef CONFIG_MACH_AM335XEVM
> # ifdef machine_arch_type
> #  undef machine_arch_type
> #  define machine_arch_type     __machine_arch_type
> # else
> #  define machine_arch_type     MACH_TYPE_AM335XEVM
> # endif
> # define machine_is_am335xevm() (machine_arch_type == MACH_TYPE_AM335XEVM)
> #else
> # define machine_is_am335xevm() (0)
> #endif

machine types are entirely meaningless for DT based systems.

> Can you comment on this? Based on that I will submit the patch.

Pointless.  You can't use machine_is_am335xevm() when you're using DT.
