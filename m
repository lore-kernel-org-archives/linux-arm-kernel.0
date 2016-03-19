From: lkp@intel.com (kbuild test robot)
Date: Sat, 19 Mar 2016 13:58:33 +0800
Subject: [PATCH v2 1/9] efi/x86: prepare GOP handling code for reuse as
 generic code
In-Reply-To: <1458319661-19762-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <201603191359.MQjwj2Qv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.5 next-20160318]
[cannot apply to efi/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/EFI-framebuffer-support-for-ARM-and-arm64/20160319-005320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: i386-randconfig-i1-201611 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Ard-Biesheuvel/EFI-framebuffer-support-for-ARM-and-arm64/20160319-005320 HEAD 26e82e0dc9f75ffe5b825ba3efbf659fbf1f138d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/x86/boot/compressed/eboot.c:10:0:
   include/linux/efi.h:1296:7: warning: 'struct screen_info' declared inside parameter list
          unsigned long size);
          ^
   include/linux/efi.h:1296:7: warning: its scope is only this definition or declaration, which is probably not what you want
>> arch/x86/boot/compressed/eboot.c:861:14: error: conflicting types for 'efi_setup_gop'
    efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
                 ^
   In file included from arch/x86/boot/compressed/eboot.c:10:0:
   include/linux/efi.h:1294:14: note: previous declaration of 'efi_setup_gop' was here
    efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
                 ^

vim +/efi_setup_gop +861 arch/x86/boot/compressed/eboot.c

   855		return status;
   856	}
   857	
   858	/*
   859	 * See if we have Graphics Output Protocol
   860	 */
 > 861	efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
   862				   struct screen_info *si, efi_guid_t *proto,
   863				   unsigned long size)
   864	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27784 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160319/790ab343/attachment-0001.obj>
