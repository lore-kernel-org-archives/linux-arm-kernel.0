From: lkp@intel.com (kbuild test robot)
Date: Sun, 2 Jul 2017 09:35:18 +0800
Subject: [PATCH] kbuild: modpost: Warn about references from rodata to
 __init text
In-Reply-To: <20170630225822.25349-1-sboyd@codeaurora.org>
Message-ID: <201707020906.fmYIPkji%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc7 next-20170630]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/kbuild-modpost-Warn-about-references-from-rodata-to-__init-text/20170702-074024
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

>> WARNING: drivers/ata/libata.o(.rodata+0xbb4): Section mismatch in reference from the variable ___param_string_force to the variable .init.data:_ata_force_param_buf
   The variable ___param_string_force references
   the variable __initdata _ata_force_param_buf
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: net/built-in.o(.rodata+0x5d08): Section mismatch in reference from the variable _msstab to the (unknown reference) .init.text:(unknown)
   The variable _msstab references
   the (unknown reference) __init (unknown)
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: drivers/tty/built-in.o(.rodata+0x1790): Section mismatch in reference from the variable _uart_proc_fops to the (unknown reference) .init.text:(unknown)
   The variable _uart_proc_fops references
   the (unknown reference) __init (unknown)
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: drivers/thermal/qcom/qcom_tsens.o(.rodata+0x434): Section mismatch in reference from the variable _ops_8916 to the function .init.text:_init_common()
   The variable _ops_8916 references
   the function __init _init_common()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: drivers/thermal/qcom/qcom_tsens.o(.rodata+0x460): Section mismatch in reference from the variable _ops_8974 to the function .init.text:_init_common()
   The variable _ops_8974 references
   the function __init _init_common()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: drivers/thermal/qcom/qcom_tsens.o(.rodata+0x4b8): Section mismatch in reference from the variable _ops_8996 to the function .init.text:_init_common()
   The variable _ops_8996 references
   the function __init _init_common()
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: drivers/of/built-in.o(.rodata+0x714): Section mismatch in reference from the variable _CSWTCH.7 to the (unknown reference) .init.text:(unknown)
   The variable _CSWTCH.7 references
   the (unknown reference) __init (unknown)
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   
--
>> WARNING: kernel/built-in.o(.rodata+0x28d8): Section mismatch in reference from the variable _param.25627 to the (unknown reference) .init.text:(unknown)
   The variable _param.25627 references
   the (unknown reference) __init (unknown)
   If the reference is valid then annotate the
   variable with or __refdata (see linux/init.h) or name the variable:
   

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44809 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170702/bbdbcdca/attachment-0001.gz>
