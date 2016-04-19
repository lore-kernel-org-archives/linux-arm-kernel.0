From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 16:42:11 +0100
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <201604192134.oK2yB12J%fengguang.wu@intel.com>
References: <201604192134.oK2yB12J%fengguang.wu@intel.com>
Message-ID: <571651D3.1030601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/04/16 14:59, kbuild test robot wrote:
> Hi,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.6-rc4 next-20160419]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-sunxi_defconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     In file included from drivers/firmware/psci.c:36:0:
>>> include/acpi/processor.h:7:22: fatal error: asm/acpi.h: No such file or directory
>      #include <asm/acpi.h>
>                           ^

Thanks again for the report, I had totally forgotten the need to check
ARM32 build. I now realize that PSCI driver is common now. Sorry for
that, fixed locally for now.

-- 
Regards,
Sudeep
