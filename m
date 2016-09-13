From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Sep 2016 11:46:40 +0800
Subject: [PATCH V2 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <1473685384-19913-11-git-send-email-okaya@codeaurora.org>
Message-ID: <201609131139.0JVTslDR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on next-20160912]
[cannot apply to linus/master linux/master robh/for-next v4.8-rc6 v4.8-rc5 v4.8-rc4 v4.8-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/dmaengine-qcom_hidma-add-MSI-interrupt-support/20160912-215548
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   drivers/dma/qcom/hidma.c: In function 'hidma_msi_capable':
>> drivers/dma/qcom/hidma.c:690:3: error: implicit declaration of function 'acpi_device_hid' [-Werror=implicit-function-declaration]
      ret = strcmp(acpi_device_hid(adev), "QCOM8062");
      ^
>> drivers/dma/qcom/hidma.c:690:9: warning: passing argument 1 of 'strcmp' makes pointer from integer without a cast
      ret = strcmp(acpi_device_hid(adev), "QCOM8062");
            ^
   In file included from include/linux/string.h:18:0,
                    from include/linux/bitmap.h:8,
                    from include/linux/cpumask.h:11,
                    from include/linux/rcupdate.h:40,
                    from include/linux/idr.h:18,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/qcom/hidma.c:45:
   arch/xtensa/include/asm/string.h:63:19: note: expected 'const char *' but argument is of type 'int'
    static inline int strcmp(const char *__cs, const char *__ct)
                      ^
   drivers/dma/qcom/hidma.c: At top level:
   drivers/dma/qcom/hidma.c:558:20: warning: 'hidma_chirq_handler_msi' defined but not used [-Wunused-function]
    static irqreturn_t hidma_chirq_handler_msi(int chirq, void *arg)
                       ^
   cc1: some warnings being treated as errors

vim +/acpi_device_hid +690 drivers/dma/qcom/hidma.c

   684							  &of_compat);
   685			if (ret)
   686				return false;
   687	
   688			ret = strcmp(of_compat, "qcom,hidma-1.1");
   689		} else {
 > 690			ret = strcmp(acpi_device_hid(adev), "QCOM8062");
   691		}
   692	
   693		return ret == 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46575 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160913/0837e931/attachment-0001.obj>
