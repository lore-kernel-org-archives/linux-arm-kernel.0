From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 16 May 2018 14:05:45 +0000
Subject: [PATCH v2 1/3] x86/mm: disable ioremap free page handling on
 x86-PAE
In-Reply-To: <201805161819.uT7J37yy%fengguang.wu@intel.com>
References: <20180515213931.23885-2-toshi.kani@hpe.com>
 <201805161819.uT7J37yy%fengguang.wu@intel.com>
Message-ID: <1526479474.2693.607.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-05-16 at 19:00 +0800, kbuild test robot wrote:
> Hi Toshi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on v4.17-rc5 next-20180515]
> [cannot apply to tip/x86/core]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Toshi-Kani/fix-free-pmd-pte-page-handlings-on-x86/20180516-183317
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: i386-randconfig-x013-201819 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> Note: the linux-review/Toshi-Kani/fix-free-pmd-pte-page-handlings-on-x86/20180516-183317 HEAD 93944422fcef9bfadf22e345c1d7a34723cc3203 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
> > > arch/x86/mm/pgtable.c:757:5: error: conflicting types for 'pud_free_pmd_page'
> 
>     int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>         ^~~~~~~~~~~~~~~~~

Thanks for catching this!  Patch reordering caused this.  Will fix.
-Toshi
