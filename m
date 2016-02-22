From: lkp@intel.com (kbuild test robot)
Date: Mon, 22 Feb 2016 23:09:19 +0800
Subject: [PATCH 2/8] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <1456148818-26257-3-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <201602222324.obRtWfaJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.5-rc5 next-20160222]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Aleksey-Makarov/arm64-move-acpi-dt-decision-earlier-in-boot-process/20160222-215244
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: microblaze-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All errors (new ones prefixed by >>):

>> arch/microblaze/kernel/prom.c:48:19: error: conflicting types for 'early_init_dt_scan_chosen_serial'
    static int __init early_init_dt_scan_chosen_serial(unsigned long node,
                      ^
   In file included from arch/microblaze/kernel/prom.c:33:0:
   include/linux/of_fdt.h:66:12: note: previous declaration of 'early_init_dt_scan_chosen_serial' was here
    extern int early_init_dt_scan_chosen_serial(void);
               ^

vim +/early_init_dt_scan_chosen_serial +48 arch/microblaze/kernel/prom.c

12e84142 Michal Simek 2009-03-27  42  #include <asm/sections.h>
12e84142 Michal Simek 2009-03-27  43  #include <asm/pci-bridge.h>
12e84142 Michal Simek 2009-03-27  44  
12e84142 Michal Simek 2009-03-27  45  #ifdef CONFIG_EARLY_PRINTK
9d0c4dfe Rob Herring  2014-04-01  46  static const char *stdout;
2aa8e375 Michal Simek 2011-04-14  47  
c0d997fb Michal Simek 2012-12-13 @48  static int __init early_init_dt_scan_chosen_serial(unsigned long node,
12e84142 Michal Simek 2009-03-27  49  				const char *uname, int depth, void *data)
12e84142 Michal Simek 2009-03-27  50  {
9d0c4dfe Rob Herring  2014-04-01  51  	int l;

:::::: The code at line 48 was first introduced by commit
:::::: c0d997fb4c4f202c55a4ed8ab9b714a81a16e5ac microblaze: Add static qualifiers

:::::: TO: Michal Simek <michal.simek@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43955 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/f4a58943/attachment-0001.obj>
