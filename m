From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 08:49:59 +0100
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <201303262144.45158.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <76d3fea8e633c122a4bc8bded96814a085a2f239.1364319776.git.michal.simek@xilinx.com>
 <201303262144.45158.arnd@arndb.de>
Message-ID: <CAHTX3dJoAW=KPAS4x-==bLY-COxCXPKdtNuEMGZEu-npR5t-hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 26 March 2013, Michal Simek wrote:
>> +void __iomem *scu_base;
>> +
>
> This cannot be a global variable in a multiplatform kernel. Can you
> make it static?

This global variable is shared because I am using it in smp code
and also it will be used in pm code we have.

What is it another way how to handle this?

Because the same problem could be with zynq_slcr_base.

Or the rule is just to use zynq_ prefix for all global variables?

Thanks,
Michal






-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
