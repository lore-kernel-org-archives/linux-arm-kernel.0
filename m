From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Nov 2015 07:35:07 +0800
Subject: [PATCH RESEND 3/4] ARM: BCM: Add SMP support for Broadcom NSP
In-Reply-To: <1446702681-45339-4-git-send-email-kapilh@broadcom.com>
Message-ID: <201511170703.AuUjhIQf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kapil,

[auto build test ERROR on: arm-soc/for-next]
[also build test ERROR on: v4.4-rc1 next-20151116]

url:    https://github.com/0day-ci/linux/commits/Kapil-Hali/dt-bindings-add-SMP-enable-method-for-Broadcom-NSP/20151105-135452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-bcm_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-bcm/built-in.o: In function `__virt_to_phys':
>> arch/arm/include/asm/memory.h:206: undefined reference to `nsp_secondary_startup'
>> arch/arm/include/asm/memory.h:206: undefined reference to `nsp_secondary_startup'

vim +206 arch/arm/include/asm/memory.h

f52bb722 Sricharan R       2013-07-29  200  
ca5a45c0 Santosh Shilimkar 2013-07-31  201  static inline phys_addr_t __virt_to_phys(unsigned long x)
dc21af99 Russell King      2011-01-04  202  {
f52bb722 Sricharan R       2013-07-29  203  	phys_addr_t t;
f52bb722 Sricharan R       2013-07-29  204  
f52bb722 Sricharan R       2013-07-29  205  	if (sizeof(phys_addr_t) == 4) {
cada3c08 Russell King      2011-01-04 @206  		__pv_stub(x, t, "add", __PV_BITS_31_24);
f52bb722 Sricharan R       2013-07-29  207  	} else {
f52bb722 Sricharan R       2013-07-29  208  		__pv_stub_mov_hi(t);
f52bb722 Sricharan R       2013-07-29  209  		__pv_add_carry_stub(x, t);

:::::: The code at line 206 was first introduced by commit
:::::: cada3c0841e1deaec4c0f92654610b028dc683ff ARM: P2V: extend to 16-bit translation offsets

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 13666 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/9ecfc2c3/attachment.obj>
