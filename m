From: lkp@intel.com (kbuild test robot)
Date: Tue, 17 Apr 2018 18:46:30 +0800
Subject: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180416215032.5023-2-mylene.josserand@bootlin.com>
References: <20180416215032.5023-2-mylene.josserand@bootlin.com>
Message-ID: <201804171811.BgBq6LBp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.17-rc1 next-20180417]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180417-113911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/cputype.h:6:0,
                    from arch/arm/mach-sunxi/headsmp.S:15:
>> include/linux/kernel.h:57:0: warning: "ALIGN" redefined
    #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
    
   In file included from arch/arm/mach-sunxi/headsmp.S:13:0:
   include/linux/linkage.h:79:0: note: this is the location of the previous definition
    #define ALIGN __ALIGN
    
   /usr/lib/gcc-cross/arm-linux-gnueabi/7/include/stdarg.h: Assembler messages:
>> /usr/lib/gcc-cross/arm-linux-gnueabi/7/include/stdarg.h:40: Error: bad instruction `typedef __builtin_va_list __gnuc_va_list'
>> /usr/lib/gcc-cross/arm-linux-gnueabi/7/include/stdarg.h:99: Error: bad instruction `typedef __gnuc_va_list va_list'
>> include/linux/stddef.h:10: Error: bad instruction `enum {'
>> include/linux/stddef.h:11: Error: junk at end of line, first unrecognized character is `,'
   include/linux/stddef.h:13: Error: junk at end of line, first unrecognized character is `}'
>> include/linux/bitops.h:29: Error: bad instruction `extern unsigned int __sw_hweight8(unsigned int w)'
>> include/linux/bitops.h:30: Error: bad instruction `extern unsigned int __sw_hweight16(unsigned int w)'
>> include/linux/bitops.h:31: Error: bad instruction `extern unsigned int __sw_hweight32(unsigned int w)'
>> include/linux/bitops.h:32: Error: bad instruction `extern unsigned long __sw_hweight64(__u64 w)'
>> arch/arm/include/asm/irqflags.h:25: Error: bad instruction `static inline unsigned long arch_local_irq_save(void)'
>> arch/arm/include/asm/irqflags.h:26: Error: junk at end of line, first unrecognized character is `{'
>> arch/arm/include/asm/irqflags.h:27: Error: bad instruction `unsigned long flags'
>> arch/arm/include/asm/irqflags.h:29: Error: bad instruction `asm volatile('
   arch/arm/include/asm/irqflags.h:30: Error: bad instruction `	mrs	%0, ""cpsr""	@ arch_local_irq_save\n"'
>> arch/arm/include/asm/irqflags.h:31: Error: bad instruction `	cpsid	i"'
>> arch/arm/include/asm/irqflags.h:32: Error: junk at end of line, first unrecognized character is `:'
>> arch/arm/include/asm/irqflags.h:33: Error: bad instruction `return flags'
   arch/arm/include/asm/irqflags.h:34: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/asm/irqflags.h:37: Error: bad instruction `static inline void arch_local_irq_enable(void)'
   arch/arm/include/asm/irqflags.h:38: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/irqflags.h:39: Error: bad instruction `asm volatile('
>> arch/arm/include/asm/irqflags.h:40: Error: bad instruction `	cpsie i			@ arch_local_irq_enable"'
   arch/arm/include/asm/irqflags.h:41: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:42: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:43: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:44: Error: junk at end of line, first unrecognized character is `}'
>> arch/arm/include/asm/irqflags.h:47: Error: bad instruction `static inline void arch_local_irq_disable(void)'
   arch/arm/include/asm/irqflags.h:48: Error: junk at end of line, first unrecognized character is `{'
   arch/arm/include/asm/irqflags.h:49: Error: bad instruction `asm volatile('
>> arch/arm/include/asm/irqflags.h:50: Error: bad instruction `	cpsid i			@ arch_local_irq_disable"'
   arch/arm/include/asm/irqflags.h:51: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:52: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:53: Error: junk at end of line, first unrecognized character is `:'
   arch/arm/include/asm/irqflags.h:54: Error: junk at end of line, first unrecognized character is `}'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65014 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/5db77122/attachment-0001.gz>
