From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jan 2016 17:18:03 +0800
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453879563-39500-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <201601271708.gQUxXACW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.5-rc1 next-20160127]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/James-Liao/clk-Move-vendor-s-Kconfig-into-CCF-menu-section/20160127-152850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-samsung (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

warning: (ARCH_BAST && MACH_VR1000 && MACH_ANUBIS && MACH_OSIRIS && MACH_RX1950) selects S3C2410_COMMON_DCLK which has unmet direct dependencies (COMMON_CLK)
warning: (CPU_S3C2410 && CPU_S3C2440 && CPU_S3C2442) selects S3C2410_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
warning: (CPU_S3C2412) selects S3C2412_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
warning: (CPU_S3C2416 && CPU_S3C2443) selects S3C2443_COMMON_CLK which has unmet direct dependencies (COMMON_CLK)
   drivers/built-in.o: In function `pwm_samsung_remove':
>> :(.text+0xba68): undefined reference to `clk_disable'
   drivers/built-in.o: In function `pwm_samsung_config':
>> :(.text+0xbc18): undefined reference to `clk_get_rate'
   :(.text+0xbc30): undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `pwm_samsung_probe':
>> :(.text+0xbf68): undefined reference to `clk_enable'
   :(.text+0xc00c): undefined reference to `clk_disable'
   drivers/built-in.o: In function `__pm_clk_remove':
   :(.text+0x83518): undefined reference to `clk_disable'
   drivers/built-in.o: In function `pm_clk_suspend':
   :(.text+0x83834): undefined reference to `clk_disable'
   drivers/built-in.o: In function `pm_clk_resume':
   :(.text+0x8389c): undefined reference to `clk_enable'
   drivers/built-in.o: In function `s3c2410_start_hc':
   :(.text+0xffc84): undefined reference to `clk_enable'
   :(.text+0xffcac): undefined reference to `clk_enable'
   drivers/built-in.o: In function `s3c2410_stop_hc':
   :(.text+0xffd68): undefined reference to `clk_disable'
   :(.text+0xffd74): undefined reference to `clk_disable'
   drivers/built-in.o: In function `_samsung_pwm_clocksource_init':
>> :(.init.text+0x6f88): undefined reference to `clk_enable'
>> :(.init.text+0x6fcc): undefined reference to `clk_get_rate'
   :(.init.text+0x7070): undefined reference to `clk_get_rate'
   arch/arm/mach-s3c24xx/built-in.o: In function `s3c2412_init_clocks':
>> :(.init.text+0x13c): undefined reference to `s3c2412_common_clk_init'
   arch/arm/mach-s3c24xx/built-in.o: In function `s3c2416_init_clocks':
>> :(.init.text+0x164): undefined reference to `s3c2443_common_clk_init'
   arch/arm/mach-s3c24xx/built-in.o: In function `s3c2443_init_clocks':
   :(.init.text+0x18c): undefined reference to `s3c2443_common_clk_init'
   arch/arm/mach-s3c24xx/built-in.o: In function `amlm5900_init_time':
>> :(.init.text+0xa24): undefined reference to `s3c2410_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `bast_init_time':
   :(.init.text+0xa80): undefined reference to `s3c2410_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `h1940_init_time':
   :(.init.text+0xed0): undefined reference to `s3c2410_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `n30_init_time':
   :(.init.text+0xfb0): undefined reference to `s3c2410_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `otom11_init_time':
   :(.init.text+0x11f4): undefined reference to `s3c2410_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o::(.init.text+0x1350): more undefined references to `s3c2410_init_clocks' follow
   arch/arm/mach-s3c24xx/built-in.o: In function `anubis_init_time':
>> :(.init.text+0x1b30): undefined reference to `s3c2440_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `at2440evb_init_time':
   :(.init.text+0x1c28): undefined reference to `s3c2440_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `mini2440_init_time':
   :(.init.text+0x1cac): undefined reference to `s3c2440_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `nexcoder_init_time':
   :(.init.text+0x204c): undefined reference to `s3c2440_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `osiris_init_time':
   :(.init.text+0x2158): undefined reference to `s3c2440_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o::(.init.text+0x228c): more undefined references to `s3c2440_init_clocks' follow
   arch/arm/mach-s3c24xx/built-in.o: In function `gta02_init_time':
>> :(.init.text+0x2438): undefined reference to `s3c2442_init_clocks'
   arch/arm/mach-s3c24xx/built-in.o: In function `rx1950_init_time':
   :(.init.text+0x26e4): undefined reference to `s3c2442_init_clocks'
   lib/lib.a(vsprintf.o): In function `clock':
>> vsprintf.c:(.text+0x2414): undefined reference to `clk_get_rate'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20185 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/a6d16192/attachment-0001.obj>
