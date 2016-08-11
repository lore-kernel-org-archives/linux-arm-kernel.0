From: lkp@intel.com (kbuild test robot)
Date: Fri, 12 Aug 2016 01:06:18 +0800
Subject: [PATCH v9 1/4] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <20160811153152.755-2-aleksey.makarov@linaro.org>
Message-ID: <201608120110.sf8xniKf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.8-rc1 next-20160811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aleksey-Makarov/ACPI-parse-the-SPCR-table/20160811-233625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   In file included from arch/sh/kernel/cpu/sh2/probe.c:13:0:
   include/linux/of_fdt.h: In function 'early_init_dt_scan_chosen_stdout':
>> include/linux/of_fdt.h:98:68: error: 'ENODEV' undeclared (first use in this function)
    static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
                                                                       ^
   include/linux/of_fdt.h:98:68: note: each undeclared identifier is reported only once for each function it appears in

vim +/ENODEV +98 include/linux/of_fdt.h

    92	extern void unflatten_and_copy_device_tree(void);
    93	extern void early_init_devtree(void *);
    94	extern void early_get_first_memblock_info(void *, phys_addr_t *);
    95	extern u64 of_flat_dt_translate_address(unsigned long node);
    96	extern void of_fdt_limit_memory(int limit);
    97	#else /* CONFIG_OF_FLATTREE */
  > 98	static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
    99	static inline void early_init_fdt_scan_reserved_mem(void) {}
   100	static inline void early_init_fdt_reserve_self(void) {}
   101	static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5199 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160812/6018429f/attachment-0001.obj>
