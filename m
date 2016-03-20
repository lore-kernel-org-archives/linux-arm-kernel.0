From: lkp@intel.com (kbuild test robot)
Date: Sun, 20 Mar 2016 22:08:07 +0800
Subject: [PATCH v7] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <1458213903-9299-1-git-send-email-fu.wei@linaro.org>
Message-ID: <201603202219.VyMGYPNm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.5 next-20160318]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-arm64-APEI-initial-support-for-aarch64/20160317-192657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/built-in.o: In function `c_show':
   :(.text+0x1c054): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
   arch/arm64/kernel/built-in.o: In function `arch_apei_get_mem_attribute':
>> :(.text+0x39148): undefined reference to `efi_mem_attributes'
   drivers/built-in.o: In function `kgdb_nmi_console_setup':
   :(.text+0x36374c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `arch_kgdb_ops' defined in .data section in arch/arm64/kernel/built-in.o
   drivers/built-in.o: In function `kgdb_register_nmi_console':
   :(.text+0x364680): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `arch_kgdb_ops' defined in .data section in arch/arm64/kernel/built-in.o
   drivers/built-in.o: In function `kgdb_unregister_nmi_console':
   :(.text+0x364960): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `arch_kgdb_ops' defined in .data section in arch/arm64/kernel/built-in.o
   drivers/built-in.o: In function `kgdbts_run_tests':
   :(.text+0x4786bc): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `arch_kgdb_ops' defined in .data section in arch/arm64/kernel/built-in.o
   drivers/built-in.o: In function `led_trigger_register':
   :(.text+0x51efc8): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `leds_list' defined in .data section in drivers/built-in.o
   drivers/built-in.o: In function `led_trigger_unregister':
   :(.text+0x51f3e0): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `leds_list' defined in .data section in drivers/built-in.o
   drivers/built-in.o: In function `vt8500_timer_read':
   :(.text+0x534c1c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
   drivers/built-in.o: In function `vt8500_timer_set_next_event':
   :(.text+0x534efc): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
   drivers/built-in.o: In function `tegra124_132_clock_init_post':
   :(.init.text+0x5b38c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `tegra_cpu_car_ops' defined in .data section in drivers/built-in.o
   drivers/built-in.o: In function `tegra210_clock_init':
   :(.init.text+0x5cdec): additional relocation overflows omitted from the output

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48000 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160320/f8654619/attachment-0001.obj>
