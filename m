From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:54:00 +0000
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <550A4BFD.4070804@huawei.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com>
Message-ID: <20150320185400.GK1474@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 04:09:33AM +0000, Hanjun Guo wrote:
> On 2015/3/19 3:05, Will Deacon wrote:
> > If you can get that in place, I'm not opposed to putting this into
> > linux-next ahead of the firmware summit in San Jose next week. Note that
> > this is not a commitment for 4.1, since I'm keen to see the outcomes of
> > next week before setting anything in stone.
> 
> OK, I will stick to this mailing list and respond as soon as I can.

This doesn't even build for me:


$ make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- allmodconfig
$ make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- Image

[...]

In file included from drivers/xen/acpi.c:33:0:
include/xen/acpi.h: In function ?xen_acpi_sleep_register?:
include/xen/acpi.h:102:3: error: ?acpi_suspend_lowlevel? undeclared (first use in this function)
   acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
   ^
include/xen/acpi.h:102:3: note: each undeclared identifier is reported only once for each function it appears in
drivers/xen/acpi.c: In function ?xen_acpi_notify_hypervisor_state?:
drivers/xen/acpi.c:61:2: error: implicit declaration of function ?HYPERVISOR_dom0_op? [-Werror=implicit-function-declaration]
  HYPERVISOR_dom0_op(&op);
  ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/xen/acpi.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/xen] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2


Am I missing some other patches?

Will
