From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Jun 2016 07:27:03 +0800
Subject: [PATCHv5] support for AD5820 camera auto-focus coil
In-Reply-To: <20160527205140.GA26767@amd>
Message-ID: <201606050736.juGfm1Mr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.7-rc1 next-20160603]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Machek/support-for-AD5820-camera-auto-focus-coil/20160528-045306
base:   git://linuxtv.org/media_tree.git master
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   drivers/media/i2c/ad5820.c: In function 'ad5820_set_ctrl':
   drivers/media/i2c/ad5820.c:168:7: error: 'V4L2_CID_FOCUS_AD5820_RAMP_TIME' undeclared (first use in this function)
   drivers/media/i2c/ad5820.c:168:7: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/media/i2c/ad5820.c:174:7: error: 'V4L2_CID_FOCUS_AD5820_RAMP_MODE' undeclared (first use in this function)
   drivers/media/i2c/ad5820.c: At top level:
   drivers/media/i2c/ad5820.c:194:10: error: 'V4L2_CID_FOCUS_AD5820_RAMP_TIME' undeclared here (not in a function)
   drivers/media/i2c/ad5820.c:205:10: error: 'V4L2_CID_FOCUS_AD5820_RAMP_MODE' undeclared here (not in a function)

vim +/V4L2_CID_FOCUS_AD5820_RAMP_MODE +174 drivers/media/i2c/ad5820.c

   162	
   163		switch (ctrl->id) {
   164		case V4L2_CID_FOCUS_ABSOLUTE:
   165			coil->focus_absolute = ctrl->val;
   166			return ad5820_update_hw(coil);
   167	
 > 168		case V4L2_CID_FOCUS_AD5820_RAMP_TIME:
   169			code = RAMP_US_TO_CODE(ctrl->val);
   170			ctrl->val = CODE_TO_RAMP_US(code);
   171			coil->focus_ramp_time = ctrl->val;
   172			break;
   173	
 > 174		case V4L2_CID_FOCUS_AD5820_RAMP_MODE:
   175			coil->focus_ramp_mode = ctrl->val;
   176			break;
   177		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43906 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160605/e107ca9e/attachment-0001.obj>
