From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Oct 2015 00:53:28 +0800
Subject: [PATCH v2 3/3] mfd: lm3533: Support initialization from Device
 Tree
In-Reply-To: <1445963373-27790-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <201510280023.PwmPMF0y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

[auto build test ERROR on ljones-mfd/for-mfd-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Bjorn-Andersson/devicetree-mfd-Add-binding-for-the-TI-LM3533/20151028-003248
config: x86_64-randconfig-x019-201543 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/mfd/lm3533-core.c: In function 'lm3533_pdata_from_of_node':
>> drivers/mfd/lm3533-core.c:830:8: error: implicit declaration of function 'of_node_cmp' [-Werror=implicit-function-declaration]
      if (!of_node_cmp(node->name, "als"))
           ^
   cc1: some warnings being treated as errors

vim +/of_node_cmp +830 drivers/mfd/lm3533-core.c

   824			dev_err(dev, "failed to parse ti,boost-ovp\n");
   825			return ret;
   826		}
   827		pdata->boost_ovp = ret;
   828	
   829		for_each_child_of_node(dev->of_node, node) {
 > 830			if (!of_node_cmp(node->name, "als"))
   831				ret = lm3533_of_parse_als_node(dev, node, pdata);
   832			else if (!of_node_cmp(node->name, "backlight"))
   833				ret = lm3533_of_parse_bl_node(dev, node, pdata);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25708 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/30190180/attachment-0001.obj>
