From: lkp@intel.com (kbuild test robot)
Date: Thu, 2 Feb 2017 06:26:40 +0800
Subject: [PATCH V8 05/10] acpi: apei: handle SEA notification type for
 ARMv8
In-Reply-To: <1485969413-23577-6-git-send-email-tbaicar@codeaurora.org>
Message-ID: <201702020641.OINuXAee%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.10-rc6 next-20170201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tyler-Baicar/Add-UEFI-2-6-and-ACPI-6-1-updates-for-RAS-on-ARM64/20170202-020320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/built-in.o: In function `do_sea':
>> arch/arm64/mm/fault.c:511: undefined reference to `ghes_notify_sea'
   arch/arm64/mm/fault.c:511:(.text+0x1868): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ghes_notify_sea'

vim +511 arch/arm64/mm/fault.c

   505	
   506		/*
   507		 * synchronize_rcu() will wait for nmi_exit(), so no need to
   508		 * rcu_read_lock().
   509		 */
   510		nmi_enter();
 > 511		ghes_notify_sea();
   512		nmi_exit();
   513	
   514		info.si_signo = SIGBUS;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170202/f7eb780a/attachment-0001.gz>
