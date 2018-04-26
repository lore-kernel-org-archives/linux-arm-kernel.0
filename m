From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Apr 2018 11:46:13 +0800
Subject: [PATCH 10/11] of: platform: provide of_early_platform_probe()
In-Reply-To: <20180424173051.15099-11-brgl@bgdev.pl>
References: <20180424173051.15099-11-brgl@bgdev.pl>
Message-ID: <201804261118.s6yOi7MR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc2]
[cannot apply to next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/platform-device-tree-support-for-early-platform-drivers/20180426-003135
config: i386-randconfig-x015-201816 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/devicetree.c:12:0:
>> include/linux/of_platform.h:94:20: error: two or more data types in declaration specifiers
    static inline void int of_early_platform_probe(void) {}
                       ^~~

vim +94 include/linux/of_platform.h

    63	
    64	/* Platform devices and busses creation */
    65	extern struct platform_device *of_platform_device_create(struct device_node *np,
    66							   const char *bus_id,
    67							   struct device *parent);
    68	
    69	extern int of_platform_device_destroy(struct device *dev, void *data);
    70	extern int of_platform_bus_probe(struct device_node *root,
    71					 const struct of_device_id *matches,
    72					 struct device *parent);
    73	#ifdef CONFIG_OF_ADDRESS
    74	extern int of_platform_populate(struct device_node *root,
    75					const struct of_device_id *matches,
    76					const struct of_dev_auxdata *lookup,
    77					struct device *parent);
    78	
    79	#ifdef CONFIG_EARLY_PLATFORM_DEVICES
    80	extern int of_early_platform_populate(struct device_node *root,
    81					      const struct of_device_id *matches,
    82					      const struct of_dev_auxdata *lookup,
    83					      struct device *parent);
    84	extern int of_early_platform_probe(void);
    85	#else /* CONFIG_EARLY_PLATFORM_DEVICES */
    86	static inline int
    87	of_early_platform_populate(struct device_node *root,
    88				   const struct of_device_id *matches,
    89				   const struct of_dev_auxdata *lookup,
    90				   struct device *parent)
    91	{
    92		return -ENOSYS;
    93	}
  > 94	static inline void int of_early_platform_probe(void) {}
    95	#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
    96	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/af3b99d0/attachment-0001.gz>
