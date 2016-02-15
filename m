From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 Feb 2016 17:56:31 +0800
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201602151740.CeSibxZc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc4 next-20160215]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/dma-mv_xor_v2-new-driver/20160215-160120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: sparc64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   In file included from include/linux/of_pci.h:5:0,
                    from drivers/of/of_pci.c:6:
>> include/linux/msi.h:203:10: error: unknown type name 'msi_alloc_info_t'
             msi_alloc_info_t *arg);
             ^
   include/linux/msi.h:207:9: error: unknown type name 'msi_alloc_info_t'
            msi_alloc_info_t *arg);
            ^
   include/linux/msi.h:216:12: error: unknown type name 'msi_alloc_info_t'
               msi_alloc_info_t *arg);
               ^
   include/linux/msi.h:217:22: error: unknown type name 'msi_alloc_info_t'
     void  (*msi_finish)(msi_alloc_info_t *arg, int retval);
                         ^
   include/linux/msi.h:218:20: error: unknown type name 'msi_alloc_info_t'
     void  (*set_desc)(msi_alloc_info_t *arg,
                       ^
   include/linux/msi.h:286:18: error: unknown type name 'msi_alloc_info_t'
           int nvec, msi_alloc_info_t *args);
                     ^
   include/linux/msi.h:288:29: error: unknown type name 'msi_alloc_info_t'
            int virq, int nvec, msi_alloc_info_t *args);
                                ^

vim +/msi_alloc_info_t +203 include/linux/msi.h

d9109698 Jiang Liu        2014-11-15  197   * @msi_check, @msi_prepare, @msi_finish, @set_desc and @handle_error
1d1e8cdc Thomas Petazzoni 2015-12-21  198   * are callbacks used by msi_domain_alloc_irqs() and related
d9109698 Jiang Liu        2014-11-15  199   * interfaces which are based on msi_desc.
f3cf8bb0 Jiang Liu        2014-11-12  200   */
f3cf8bb0 Jiang Liu        2014-11-12  201  struct msi_domain_ops {
aeeb5965 Jiang Liu        2014-11-15  202  	irq_hw_number_t	(*get_hwirq)(struct msi_domain_info *info,
aeeb5965 Jiang Liu        2014-11-15 @203  				     msi_alloc_info_t *arg);
f3cf8bb0 Jiang Liu        2014-11-12  204  	int		(*msi_init)(struct irq_domain *domain,
f3cf8bb0 Jiang Liu        2014-11-12  205  				    struct msi_domain_info *info,
f3cf8bb0 Jiang Liu        2014-11-12  206  				    unsigned int virq, irq_hw_number_t hwirq,

:::::: The code at line 203 was first introduced by commit
:::::: aeeb59657c35da64068336c20068da237f41ab76 genirq: Provide default callbacks for msi_domain_ops

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45116 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/fd5e58b0/attachment-0001.obj>
