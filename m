From: lkp@intel.com (kbuild test robot)
Date: Mon, 6 Jun 2016 01:51:34 +0800
Subject: [PATCH 7/7] thermal: qoriq: Add thermal management support
In-Reply-To: <1464937059-19349-7-git-send-email-hongtao.jia@nxp.com>
Message-ID: <201606060137.uvl98Wrz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on v4.7-rc1]
[also build test ERROR on next-20160603]
[cannot apply to robh/for-next soc-thermal/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jia-Hongtao/dt-bindings-Update-QorIQ-TMU-thermal-bindings/20160603-154428
config: um-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   drivers/thermal/qoriq_thermal.c: In function 'qoriq_tmu_probe':
>> drivers/thermal/qoriq_thermal.c:255:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
     iounmap(data->regs);
     ^~~~~~~
   cc1: some warnings being treated as errors

vim +/iounmap +255 drivers/thermal/qoriq_thermal.c

   249		site |= 0x1 << (15 - data->sensor_id);
   250		tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
   251	
   252		return 0;
   253	
   254	err_tmu:
 > 255		iounmap(data->regs);
   256	
   257	err_iomap:
   258		platform_set_drvdata(pdev, NULL);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18145 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/66e2140f/attachment-0001.obj>
