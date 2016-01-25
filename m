From: lkp@intel.com (kbuild test robot)
Date: Mon, 25 Jan 2016 21:53:49 +0800
Subject: [PATCH v6] kernel: add kcov code coverage
In-Reply-To: <1453726850-49137-1-git-send-email-dvyukov@google.com>
Message-ID: <201601252108.oXiP6kOR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

[auto build test ERROR on v4.5-rc1]
[also build test ERROR on next-20160125]
[cannot apply to tip/x86/core kbuild/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Vyukov/kernel-add-kcov-code-coverage/20160125-210230
config: x86_64-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> Makefile:679: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler
>> gcc-5: error: unrecognized command line option '-fsanitize-coverage=trace-pc'
   make[2]: *** [arch/x86/purgatory/purgatory.o] Error 1
>> gcc-5: error: unrecognized command line option '-fsanitize-coverage=trace-pc'
   make[2]: *** [arch/x86/purgatory/sha256.o] Error 1
>> gcc-5: error: unrecognized command line option '-fsanitize-coverage=trace-pc'
   make[2]: *** [arch/x86/purgatory/string.o] Error 1
   make[2]: Target 'arch/x86/purgatory/kexec-purgatory.c' not remade because of errors.
   make[1]: *** [archprepare] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +679 Makefile

   673	endif
   674	endif
   675	KBUILD_CFLAGS += $(stackp-flag)
   676	
   677	ifdef CONFIG_KCOV
   678	  ifeq ($(call cc-option, $(CFLAGS_KCOV)),)
 > 679	    $(warning Cannot use CONFIG_KCOV: \
   680	             -fsanitize-coverage=trace-pc is not supported by compiler)
   681	  endif
   682	endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52342 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/5a544464/attachment-0001.obj>
