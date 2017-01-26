From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Jan 2017 20:55:50 +0800
Subject: [PATCH] security/keys: add CONFIG_KEYS_COMPAT to Kconfig
In-Reply-To: <1485431368-8662-1-git-send-email-bilal.amarni@gmail.com>
Message-ID: <201701262036.mMS7eB5U%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bilal,

[auto build test ERROR on arm-soc/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bilal-Amarni/security-keys-add-CONFIG_KEYS_COMPAT-to-Kconfig/20170126-195458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: x86_64-randconfig-x014-201704
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        make ARCH=x86_64  randconfig
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> arch/x86/Kconfig:2772: unexpected 'endmenu' within if block
>> lib/Kconfig:554: syntax error
>> arch/x86/Kconfig:2719: missing end statement for this entry
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> arch/x86/Kconfig:2772: unexpected 'endmenu' within if block
>> lib/Kconfig:554: syntax error
>> arch/x86/Kconfig:2719: missing end statement for this entry
   make[2]: *** [olddefconfig] Error 1
   make[2]: Target 'oldnoconfig' not remade because of errors.
   make[1]: *** [oldnoconfig] Error 2
   make: *** [sub-make] Error 2

vim +/endmenu +2772 arch/x86/Kconfig

e3263ab38 David Herrmann  2013-08-02  2713  
e3263ab38 David Herrmann  2013-08-02  2714  	  If unsure, say Y.
e3263ab38 David Herrmann  2013-08-02  2715  
e279b6c1d Sam Ravnborg    2007-11-06  2716  endmenu
e279b6c1d Sam Ravnborg    2007-11-06  2717  
e279b6c1d Sam Ravnborg    2007-11-06  2718  
e279b6c1d Sam Ravnborg    2007-11-06 @2719  menu "Executable file formats / Emulations"
e279b6c1d Sam Ravnborg    2007-11-06  2720  
e279b6c1d Sam Ravnborg    2007-11-06  2721  source "fs/Kconfig.binfmt"
e279b6c1d Sam Ravnborg    2007-11-06  2722  
e279b6c1d Sam Ravnborg    2007-11-06  2723  config IA32_EMULATION
e279b6c1d Sam Ravnborg    2007-11-06  2724  	bool "IA32 Emulation"
e279b6c1d Sam Ravnborg    2007-11-06  2725  	depends on X86_64
39f88911b Ingo Molnar     2016-11-15  2726  	select ARCH_WANT_OLD_COMPAT_IPC
d1603990e Randy Dunlap    2013-06-18  2727  	select BINFMT_ELF
a97f52e67 Roland McGrath  2008-01-30  2728  	select COMPAT_BINFMT_ELF
39f88911b Ingo Molnar     2016-11-15  2729  	select COMPAT_OLD_SIGACTION
8f9ca475c Ingo Molnar     2009-02-05  2730  	---help---
5fd92e65a H. J. Lu        2012-02-19  2731  	  Include code to run legacy 32-bit programs under a
5fd92e65a H. J. Lu        2012-02-19  2732  	  64-bit kernel. You should likely turn this on, unless you're
5fd92e65a H. J. Lu        2012-02-19  2733  	  100% sure that you don't have any 32-bit programs left.
e279b6c1d Sam Ravnborg    2007-11-06  2734  
e279b6c1d Sam Ravnborg    2007-11-06  2735  config IA32_AOUT
e279b6c1d Sam Ravnborg    2007-11-06  2736  	tristate "IA32 a.out support"
6b213e1bc David Woodhouse 2008-06-16  2737  	depends on IA32_EMULATION
8f9ca475c Ingo Molnar     2009-02-05  2738  	---help---
e279b6c1d Sam Ravnborg    2007-11-06  2739  	  Support old a.out binaries in the 32bit emulation.
e279b6c1d Sam Ravnborg    2007-11-06  2740  
0bf627639 H. Peter Anvin  2012-02-27  2741  config X86_X32
6ea303864 Kees Cook       2012-10-02  2742  	bool "x32 ABI for 64-bit mode"
9b54050bf Brian Gerst     2015-06-22  2743  	depends on X86_64
5fd92e65a H. J. Lu        2012-02-19  2744  	---help---
5fd92e65a H. J. Lu        2012-02-19  2745  	  Include code to run binaries for the x32 native 32-bit ABI
5fd92e65a H. J. Lu        2012-02-19  2746  	  for 64-bit processors.  An x32 process gets access to the
5fd92e65a H. J. Lu        2012-02-19  2747  	  full 64-bit register file and wide data path while leaving
5fd92e65a H. J. Lu        2012-02-19  2748  	  pointers at 32 bits for smaller memory footprint.
5fd92e65a H. J. Lu        2012-02-19  2749  
5fd92e65a H. J. Lu        2012-02-19  2750  	  You will need a recent binutils (2.22 or later) with
5fd92e65a H. J. Lu        2012-02-19  2751  	  elf32_x86_64 support enabled to compile a kernel with this
5fd92e65a H. J. Lu        2012-02-19  2752  	  option set.
5fd92e65a H. J. Lu        2012-02-19  2753  
953fee1d8 Ingo Molnar     2016-11-15  2754  config COMPAT_32
953fee1d8 Ingo Molnar     2016-11-15  2755  	def_bool y
953fee1d8 Ingo Molnar     2016-11-15  2756  	depends on IA32_EMULATION || X86_32
953fee1d8 Ingo Molnar     2016-11-15  2757  	select HAVE_UID16
953fee1d8 Ingo Molnar     2016-11-15  2758  	select OLD_SIGSUSPEND3
953fee1d8 Ingo Molnar     2016-11-15  2759  
e279b6c1d Sam Ravnborg    2007-11-06  2760  config COMPAT
3c2362e62 Harvey Harrison 2008-01-30  2761  	def_bool y
0bf627639 H. Peter Anvin  2012-02-27  2762  	depends on IA32_EMULATION || X86_X32
e279b6c1d Sam Ravnborg    2007-11-06  2763  
3120e25ef Jan Beulich     2012-09-10  2764  if COMPAT
e279b6c1d Sam Ravnborg    2007-11-06  2765  config COMPAT_FOR_U64_ALIGNMENT
3120e25ef Jan Beulich     2012-09-10  2766  	def_bool y
e279b6c1d Sam Ravnborg    2007-11-06  2767  
e279b6c1d Sam Ravnborg    2007-11-06  2768  config SYSVIPC_COMPAT
3c2362e62 Harvey Harrison 2008-01-30  2769  	def_bool y
3120e25ef Jan Beulich     2012-09-10  2770  	depends on SYSVIPC
e279b6c1d Sam Ravnborg    2007-11-06  2771  
e279b6c1d Sam Ravnborg    2007-11-06 @2772  endmenu
e279b6c1d Sam Ravnborg    2007-11-06  2773  
e279b6c1d Sam Ravnborg    2007-11-06  2774  
e5beae169 Keith Packard   2008-11-03  2775  config HAVE_ATOMIC_IOMAP

:::::: The code at line 2772 was first introduced by commit
:::::: e279b6c1d329e50b766bce96aacc197eae8a053b x86: start unification of arch/x86/Kconfig.*

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: Sam Ravnborg <sam@ravnborg.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
