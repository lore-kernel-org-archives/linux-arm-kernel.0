From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 23 Mar 2015 15:17:22 +0000
Subject: Renaming ARM_CCI
In-Reply-To: <CAD3Xx4+ECHuri6nT7=gpM5EnAqZM2zW8TK4T0yjW+aMMz=pwdA@mail.gmail.com>
References: <CAD3Xx4+ECHuri6nT7=gpM5EnAqZM2zW8TK4T0yjW+aMMz=pwdA@mail.gmail.com>
Message-ID: <55102E82.1080404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 15:10, Valentin Rothberg wrote:
> Hi Suzuki,
>
> your commit c9966c98697a ("arm-cci: Split the code for PMU vs driver
> support") renames the Kconfig option ARM_CCI to ARM_CCI400_PORT_CTRL.
> However, the commit does not rename all references on ARM_CCI:
>
It renames, but still, leaves the ARM_CCI to build the arm-cci.o, which 
is in the original commit.

> drivers/bus/Kconfig:29: select ARM_CCI
> drivers/bus/Makefile:6:obj-$(CONFIG_ARM_CCI)            += arm-cci.o
> include/linux/arm-cci.h:31:#ifdef CONFIG_ARM_CCI
>
> Is this intentional or is there a patch scheduled somewhere to fix this issue?
Yes, it is. This problem was introduced due to a conflict in the linux-next.

See :
  https://lkml.org/lkml/2015/3/22/240

Cheers
Suzuki
