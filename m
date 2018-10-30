From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 Oct 2018 19:31:06 +0800
Subject: [PATCH] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
In-Reply-To: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
Message-ID: <201810301913.XPGMpz0a%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhupesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v4.19 next-20181030]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bhupesh-Sharma/x86_64-vmcoreinfo-Append-page_offset_base-to-vmcoreinfo/20181027-075816
config: x86_64-randconfig-s4-10301649 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
>> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'
>> arch/x86/kernel/machine_kexec_64.c:359: undefined reference to `page_offset_base'

vim +359 arch/x86/kernel/machine_kexec_64.c

   352	
   353	void arch_crash_save_vmcoreinfo(void)
   354	{
   355		VMCOREINFO_NUMBER(phys_base);
   356		VMCOREINFO_SYMBOL(init_top_pgt);
   357		vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
   358				pgtable_l5_enabled());
 > 359		VMCOREINFO_NUMBER(page_offset_base);
   360	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33580 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181030/7d72a7ae/attachment-0001.gz>
