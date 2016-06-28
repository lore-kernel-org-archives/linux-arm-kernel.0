From: lkp@intel.com (kbuild test robot)
Date: Tue, 28 Jun 2016 14:25:36 +0800
Subject: [PATCH v3 03/10] input: tps65218-pwrbutton: Add
 platform_device_id table
In-Reply-To: <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
Message-ID: <201606281427.iovLfzW6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7-rc5 next-20160627]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/mfd-tps65218-Clean-ups/20160628-141354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

>> drivers/input/misc/tps65218-pwrbutton.c:120:1: error: expected ',' or ';' before 'extern'

vim +120 drivers/input/misc/tps65218-pwrbutton.c

   114	MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
   115	
   116	static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
   117		{ "tps65218-pwrbutton", },
   118		{ /* sentinel */ }
   119	}
 > 120	MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
   121	
   122	static struct platform_driver tps65218_pwron_driver = {
   123		.probe	= tps65218_pwron_probe,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/a3cfe2e9/attachment-0001.obj>
