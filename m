From: lkp@intel.com (kbuild test robot)
Date: Thu, 21 Jan 2016 00:04:09 +0800
Subject: [PATCH v1 3/3] mmc: pwrseq: convert to proper platform device
In-Reply-To: <1453286796-9746-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <201601210051.TQCHmnMK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

[auto build test ERROR on ulf.hansson-mmc/next]
[also build test ERROR on next-20160120]
[cannot apply to v4.4]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/mmc-pwrseq-convert-to-proper-driver/20160120-185020
base:   https://git.linaro.org/people/ulf.hansson/mmc next
config: tile-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All error/warnings (new ones prefixed by >>):

>> drivers/mmc/core/pwrseq_simple.c:149:1: warning: data definition has no type or storage class [enabled by default]
>> drivers/mmc/core/pwrseq_simple.c:149:1: error: type defaults to 'int' in declaration of 'device_initcall'
   drivers/mmc/core/pwrseq_simple.c:149:1: warning: parameter names (without types) in function declaration [enabled by default]
   drivers/mmc/core/pwrseq_simple.c:149:1: warning: 'mmc_pwrseq_simple_driver_init' defined but not used
   cc1: some warnings being treated as errors

vim +149 drivers/mmc/core/pwrseq_simple.c

   143		.driver = {
   144			.name = "pwrseq_simple",
   145			.of_match_table = mmc_pwrseq_simple_of_match,
   146		},
   147	};
   148	
 > 149	builtin_platform_driver(mmc_pwrseq_simple_driver);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42887 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/27e6bf60/attachment-0001.obj>
