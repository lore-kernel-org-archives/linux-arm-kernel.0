From: lkp@intel.com (kbuild test robot)
Date: Thu, 14 Jul 2016 00:21:03 +0800
Subject: [PATCH] coresight: Use local coresight_desc instances
In-Reply-To: <1468418372-30797-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201607140048.yap01jMZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on next-20160712]
[cannot apply to v4.7-rc7 v4.7-rc6 v4.7-rc5 v4.7-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/coresight-Use-local-coresight_desc-instances/20160713-220832
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-replicator-qcom.c: In function 'replicator_probe':
>> drivers/hwtracing/coresight/coresight-replicator-qcom.c:137:34: error: invalid type argument of unary '*' (have 'struct coresight_desc')
     desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
                                     ^
>> drivers/hwtracing/coresight/coresight-replicator-qcom.c:138:6: error: wrong type argument to unary exclamation mark
     if (!desc)
         ^

vim +137 drivers/hwtracing/coresight/coresight-replicator-qcom.c

620cf787 Pratik Patel     2015-05-19  131  		return PTR_ERR(base);
620cf787 Pratik Patel     2015-05-19  132  
620cf787 Pratik Patel     2015-05-19  133  	drvdata->base = base;
620cf787 Pratik Patel     2015-05-19  134  	dev_set_drvdata(dev, drvdata);
620cf787 Pratik Patel     2015-05-19  135  	pm_runtime_put(&adev->dev);
620cf787 Pratik Patel     2015-05-19  136  
620cf787 Pratik Patel     2015-05-19 @137  	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
620cf787 Pratik Patel     2015-05-19 @138  	if (!desc)
620cf787 Pratik Patel     2015-05-19  139  		return -ENOMEM;
620cf787 Pratik Patel     2015-05-19  140  
93c12082 Suzuki K Poulose 2016-07-13  141  	desc.type = CORESIGHT_DEV_TYPE_LINK;

:::::: The code at line 137 was first introduced by commit
:::::: 620cf787c121f39b5223e43bad3d1b7c66ecead5 coresight: replicator: Add Qualcomm CoreSight Replicator driver

:::::: TO: Pratik Patel <pratikp@codeaurora.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58365 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160714/b7423581/attachment-0001.obj>
