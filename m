From: lkp@intel.com (kbuild test robot)
Date: Sat, 13 Oct 2018 05:35:15 +0800
Subject: [arm-platforms:irq/generic_handle_domain_irq 8/29]
 arch/powerpc/sysdev/mpic.c:605:12: error: 'NUM_ISA_INTERRUPTS' undeclared;
 did you mean 'H_INTERRUPT'?
Message-ID: <201810130541.BnMvRGZo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/generic_handle_domain_irq
head:   ce79686e608f93452f13339a5cadaa6836fe82b8
commit: cbd3df331c399ae034a1966d67be0cce252ba44f [8/29] irqdomain: Kill irq_domain_add_legacy_isa
config: powerpc-maple_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cbd3df331c399ae034a1966d67be0cce252ba44f
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/mpic.c: In function 'mpic_find':
>> arch/powerpc/sysdev/mpic.c:605:12: error: 'NUM_ISA_INTERRUPTS' undeclared (first use in this function); did you mean 'H_INTERRUPT'?
     if (irq < NUM_ISA_INTERRUPTS)
               ^~~~~~~~~~~~~~~~~~
               H_INTERRUPT
   arch/powerpc/sysdev/mpic.c:605:12: note: each undeclared identifier is reported only once for each function it appears in

vim +605 arch/powerpc/sysdev/mpic.c

14cf11af Paul Mackerras         2005-09-26  601  
14cf11af Paul Mackerras         2005-09-26  602  /* Find an mpic associated with a given linux interrupt */
d69a78d7 Tony Breeds            2009-04-07  603  static struct mpic *mpic_find(unsigned int irq)
14cf11af Paul Mackerras         2005-09-26  604  {
0ebfff14 Benjamin Herrenschmidt 2006-07-03 @605  	if (irq < NUM_ISA_INTERRUPTS)
14cf11af Paul Mackerras         2005-09-26  606  		return NULL;
7df2457d Olof Johansson         2007-01-28  607  
ec775d0e Thomas Gleixner        2011-03-25  608  	return irq_get_chip_data(irq);
d69a78d7 Tony Breeds            2009-04-07  609  }
7df2457d Olof Johansson         2007-01-28  610  

:::::: The code at line 605 was first introduced by commit
:::::: 0ebfff1491ef85d41ddf9c633834838be144f69f [POWERPC] Add new interrupt mapping core and change platforms to use it

:::::: TO: Benjamin Herrenschmidt <benh@kernel.crashing.org>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181013/5116d4d2/attachment-0001.gz>
