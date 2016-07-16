From: lkp@intel.com (kbuild test robot)
Date: Sun, 17 Jul 2016 01:22:19 +0800
Subject: [RCF 1/3] hwmon: Add ads1118 driver
In-Reply-To: <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
Message-ID: <201607170105.oInVODwB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on hwmon/hwmon-next]
[also build test WARNING on v4.7-rc7 next-20160715]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joshua-Clayton/hwmon-add-driver-for-TI-ADS1118/20160716-082056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: x86_64-randconfig-x001-201629 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/hwmon/ads1118.c: In function 'ads1118_get_cfg':
>> drivers/hwmon/ads1118.c:421:22: warning: unused variable 'node' [-Wunused-variable]
     struct device_node *node;
                         ^~~~

vim +/node +421 drivers/hwmon/ads1118.c

   405				ads->channel_data[i].cfg &= ~(BIT(ADS1118_PULL_UP));
   406	}
   407	#endif
   408	
   409	static void ads1118_temp_chan_enable(struct ads1118 *ads)
   410	{
   411		struct ads_channel *chan = &ads->channel_data[ADS1118_TEMP_CHAN];
   412		unsigned int rate = ads->ref->rates[ADS1118_DEFAULT_DR];
   413	
   414		chan->cfg = ADS1118_TEMP_CFG;
   415		ads1118_chan_set_rate(ads, chan, rate);
   416		chan->enabled = true;
   417	}
   418	
   419	static int ads1118_get_cfg(struct ads1118 *ads)
   420	{
 > 421		struct device_node *node;
   422	
   423	#ifndef CONFIG_OF
   424		return -EINVAL;
   425	#else
   426		if (!ads->dev->of_node
   427		    || !of_get_next_child(ads->dev->of_node, NULL))
   428			return -EINVAL;
   429	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20855 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160717/1c2cbf0f/attachment-0001.obj>
