From: lkp@intel.com (kbuild test robot)
Date: Mon, 21 Dec 2015 06:12:05 +0800
Subject: [PATCH 4.4-rc5 v22 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit
 FIQ
In-Reply-To: <1450644757-18734-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <201512210618.hMZqsBKl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

[auto build test ERROR on v4.4-rc5]
[also build test ERROR on next-20151218]
[cannot apply to tip/irq/core]

url:    https://github.com/0day-ci/linux/commits/Daniel-Thompson/irq-arm-Use-FIQ-for-NMI-backtrace-when-possible/20151221-045854
config: arm-iop-adma (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/traps.c: In function 'handle_fiq_as_nmi':
>> arch/arm/kernel/traps.c:489:2: error: implicit declaration of function 'handle_arch_irq' [-Werror=implicit-function-declaration]
     handle_arch_irq(regs);
     ^
   cc1: some warnings being treated as errors

vim +/handle_arch_irq +489 arch/arm/kernel/traps.c

   483		 * Either the interrupt controller supports FIQ, meaning it will
   484		 * do the right thing with this call, or we will end up treating a
   485		 * spurious FIQ (which is normally fatal) as though it were an IRQ
   486		 * which, although it risks deadlock, still gives us a sporting
   487		 * chance of surviving long enough to log errors.
   488		 */
 > 489		handle_arch_irq(regs);
   490	
   491		nmi_exit();
   492	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20864 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151221/90a009bc/attachment-0001.obj>
