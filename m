From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Dec 2017 07:21:59 +0800
Subject: [PATCH v4 02/10] pinctrl: axp209: add pinctrl features
In-Reply-To: <71c9da94df2a5938cb8c092e40f8e36eec0b01c3.1512135804.git-series.quentin.schulz@free-electrons.com>
References: <71c9da94df2a5938cb8c092e40f8e36eec0b01c3.1512135804.git-series.quentin.schulz@free-electrons.com>
Message-ID: <201712060620.7QzKhd9b%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pinctrl/devel]
[also build test ERROR on v4.15-rc2 next-20171205]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Quentin-Schulz/pinctrl-move-gpio-axp209-to-pinctrl/20171204-050707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: i386-randconfig-h1-12060258 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers//pinctrl/pinctrl-axp209.c:290:21: error: 'pinconf_generic_dt_node_to_map_group' undeclared here (not in a function)
     .dt_node_to_map  = pinconf_generic_dt_node_to_map_group,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers//pinctrl/pinctrl-axp209.c:291:18: error: 'pinconf_generic_dt_free_map' undeclared here (not in a function)
     .dt_free_map  = pinconf_generic_dt_free_map,
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/pinconf_generic_dt_node_to_map_group +290 drivers//pinctrl/pinctrl-axp209.c

   288	
   289	static const struct pinctrl_ops axp20x_pctrl_ops = {
 > 290		.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
 > 291		.dt_free_map		= pinconf_generic_dt_free_map,
   292		.get_groups_count	= axp20x_groups_cnt,
   293		.get_group_name		= axp20x_group_name,
   294		.get_group_pins		= axp20x_group_pins,
   295	};
   296	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28831 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/d4447d00/attachment-0001.gz>
