From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Mon, 23 Mar 2015 16:10:14 +0100
Subject: Renaming ARM_CCI
Message-ID: <CAD3Xx4+ECHuri6nT7=gpM5EnAqZM2zW8TK4T0yjW+aMMz=pwdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

your commit c9966c98697a ("arm-cci: Split the code for PMU vs driver
support") renames the Kconfig option ARM_CCI to ARM_CCI400_PORT_CTRL.
However, the commit does not rename all references on ARM_CCI:

drivers/bus/Kconfig:29: select ARM_CCI
drivers/bus/Makefile:6:obj-$(CONFIG_ARM_CCI)            += arm-cci.o
include/linux/arm-cci.h:31:#ifdef CONFIG_ARM_CCI

Is this intentional or is there a patch scheduled somewhere to fix this issue?

I detected your commit with scripts/checkkconfigsymbols.py.  A recent
patch added support to make the script git aware, so that it lets you
check git commits.  It's added to Greg's misc tree and should arrive
soon in linux-next.

[linux-next]$ ./checkkconfigsymbols.py --diff next-20150320..next-20150323
ARM_CCI drivers/bus/Makefile, include/linux/arm-cci.h, drivers/bus/Kconfig

Kind regards,
 Valentin
