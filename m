From: lkp@intel.com (kbuild test robot)
Date: Sat, 12 Mar 2016 02:35:37 +0800
Subject: [PATCH V2 3/3] vfio, platform: add QTI HIDMA reset driver
In-Reply-To: <1457715275-11925-4-git-send-email-okaya@codeaurora.org>
Message-ID: <201603120252.yf2ZbKlU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test ERROR on vfio/next]
[also build test ERROR on v4.5-rc7 next-20160311]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/vfio-platform-add-HIDMA-and-ACPI-support/20160312-005737
base:   https://github.com/awilliam/linux-vfio.git next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/vfio/platform/reset/vfio_platform_qcomhidma.c:97:28: error: expected declaration specifiers or '...' before string constant
    VFIO_PLATFORM_MODULE_ALIAS("qcom,hidma-1.0");
                               ^
   drivers/vfio/platform/reset/vfio_platform_qcomhidma.c:98:28: error: expected declaration specifiers or '...' before string constant
    VFIO_PLATFORM_MODULE_ALIAS("QCOM8061");
                               ^

vim +97 drivers/vfio/platform/reset/vfio_platform_qcomhidma.c

    91	
    92		pr_info("HIDMA channel reset\n");
    93		return 0;
    94	}
    95	module_vfio_reset_handler("qcom,hidma-1.0", "QCOM8061",
    96				  vfio_platform_qcomhidma_reset);
  > 97	VFIO_PLATFORM_MODULE_ALIAS("qcom,hidma-1.0");
    98	VFIO_PLATFORM_MODULE_ALIAS("QCOM8061");
    99	
   100	MODULE_LICENSE("GPL v2");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56252 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160312/d0f56960/attachment-0001.obj>
