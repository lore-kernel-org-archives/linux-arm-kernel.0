From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Thu, 1 Nov 2018 21:19:46 +0530
Subject: [PATCH] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <201810301913.XPGMpz0a%fengguang.wu@intel.com>
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <201810301913.XPGMpz0a%fengguang.wu@intel.com>
Message-ID: <CACi5LpP4+H-9X3AuAt3j=SA5Y4Qk6nA-7D4HdcRF8JGaqKx_fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2018 at 5:02 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Bhupesh,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v4.19 next-20181030]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bhupesh-Sharma/x86_64-vmcoreinfo-Append-page_offset_base-to-vmcoreinfo/20181027-075816
> config: x86_64-randconfig-s4-10301649 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
> >> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
>
> vim +359 arch/x86/kernel/machine_kexec_64.c
>
>    352
>    353  void arch_crash_save_vmcoreinfo(void)
>    354  {
>    355          VMCOREINFO_NUMBER(phys_base);
>    356          VMCOREINFO_SYMBOL(init_top_pgt);
>    357          vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>    358                          pgtable_l5_enabled());
>  > 359          VMCOREINFO_NUMBER(page_offset_base);
>    360
>

Thanks I can reproduce the issue, I will send a v2 shortly to fix the
build issue.

Regards,
Bhupesh
