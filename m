From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 9 Jul 2016 20:38:06 +0800
Subject: [arm64:for-next/core 32/34] arch/arm64/include/asm/vdso.h:30:36:
 fatal error: generated/vdso-offsets.h: No such file or directory
Message-ID: <201607092002.eGpxGqQ0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
head:   16c11325cc44f0614a45e584d439e195059c3f5a
commit: 90f777beb788d08300f4a1482cb4fd37a401b472 [32/34] arm64: Fix vdso-offsets.h dependency
config: arm64-alldefconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 90f777beb788d08300f4a1482cb4fd37a401b472
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm64/for-next/core HEAD 16c11325cc44f0614a45e584d439e195059c3f5a builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/signal.c:36:0:
>> arch/arm64/include/asm/vdso.h:30:36: fatal error: generated/vdso-offsets.h: No such file or directory
   compilation terminated.

vim +30 arch/arm64/include/asm/vdso.h

9031fefd Will Deacon 2012-03-05  14   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
9031fefd Will Deacon 2012-03-05  15   */
9031fefd Will Deacon 2012-03-05  16  #ifndef __ASM_VDSO_H
9031fefd Will Deacon 2012-03-05  17  #define __ASM_VDSO_H
9031fefd Will Deacon 2012-03-05  18  
9031fefd Will Deacon 2012-03-05  19  #ifdef __KERNEL__
9031fefd Will Deacon 2012-03-05  20  
9031fefd Will Deacon 2012-03-05  21  /*
9031fefd Will Deacon 2012-03-05  22   * Default link address for the vDSO.
9031fefd Will Deacon 2012-03-05  23   * Since we randomise the VDSO mapping, there's little point in trying
9031fefd Will Deacon 2012-03-05  24   * to prelink this.
9031fefd Will Deacon 2012-03-05  25   */
9031fefd Will Deacon 2012-03-05  26  #define VDSO_LBASE	0x0
9031fefd Will Deacon 2012-03-05  27  
9031fefd Will Deacon 2012-03-05  28  #ifndef __ASSEMBLY__
9031fefd Will Deacon 2012-03-05  29  
9031fefd Will Deacon 2012-03-05 @30  #include <generated/vdso-offsets.h>
9031fefd Will Deacon 2012-03-05  31  
9031fefd Will Deacon 2012-03-05  32  #define VDSO_SYMBOL(base, name)						   \
9031fefd Will Deacon 2012-03-05  33  ({									   \
9031fefd Will Deacon 2012-03-05  34  	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
9031fefd Will Deacon 2012-03-05  35  })
9031fefd Will Deacon 2012-03-05  36  
9031fefd Will Deacon 2012-03-05  37  #endif /* !__ASSEMBLY__ */
9031fefd Will Deacon 2012-03-05  38  

:::::: The code at line 30 was first introduced by commit
:::::: 9031fefde6f2ac1d1e5e0f8f4b22db4a091229bb arm64: VDSO support

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 8248 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/09c733db/attachment-0001.obj>
