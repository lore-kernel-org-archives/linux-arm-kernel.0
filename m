From: lkp@intel.com (kbuild test robot)
Date: Thu, 9 Jun 2016 21:51:47 +0800
Subject: [PATCH v4 1/2] i2c: qup: add ACPI support
In-Reply-To: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Message-ID: <201606092141.P9tGizvu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Austin-Christ/i2c-qup-add-ACPI-support/20160609-022325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from drivers/i2c/busses/i2c-qup.c:27:0:
>> drivers/i2c/busses/i2c-qup.c:1665:27: error: 'qup_i2c_acpi_ids' undeclared here (not in a function)
    MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids);
                              ^
   include/linux/module.h:223:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                        ^
   include/linux/module.h:223:27: error: '__mod_acpi__qup_i2c_acpi_ids_device_table' aliased to undefined symbol 'qup_i2c_acpi_ids'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                              ^
   drivers/i2c/busses/i2c-qup.c:1665:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids);
    ^

vim +/qup_i2c_acpi_ids +1665 drivers/i2c/busses/i2c-qup.c

  1659	
  1660	#if IS_ENABLED(CONFIG_ACPI)
  1661	static const struct acpi_device_id qup_i2c_acpi_match[] = {
  1662		{ "QCOM8010"},
  1663		{ },
  1664	};
> 1665	MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids);
  1666	#endif
  1667	
  1668	static struct platform_driver qup_i2c_driver = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50194 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/9a6ad370/attachment-0001.obj>
