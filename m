From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 6 Jan 2017 06:19:53 +0800
Subject: [arm:clearfog 25/65] htmldocs: drivers/net/phy/phy.c:278: warning:
 No description found for parameter 'speed'
Message-ID: <201701060640.wHmkUVqb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git clearfog
head:   a0b3b7ea35687eaa7b1836bcdbbe10daf034c621
commit: b73483caa6bece0e854d064bb931dc25f84c935e [25/65] net: phy: improve phylib correctness for non-autoneg settings
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'speed'
>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'duplex'
>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'supported'
>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'speed'
>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'duplex'
>> drivers/net/phy/phy.c:278: warning: No description found for parameter 'supported'

vim +/speed +278 drivers/net/phy/phy.c

b73483ca Russell King  2017-01-05  262  					break;
b73483ca Russell King  2017-01-05  263  			}
b73483ca Russell King  2017-01-05  264  		}
b73483ca Russell King  2017-01-05  265  	}
00db8189 Andy Fleming  2005-07-30  266  
b73483ca Russell King  2017-01-05  267  	if (!match && !exact)
b73483ca Russell King  2017-01-05  268  		match = last;
00db8189 Andy Fleming  2005-07-30  269  
b73483ca Russell King  2017-01-05  270  	return match;
00db8189 Andy Fleming  2005-07-30  271  }
00db8189 Andy Fleming  2005-07-30  272  
b3df0da8 Randy Dunlap  2007-03-06  273  /**
b3df0da8 Randy Dunlap  2007-03-06  274   * phy_find_valid - find a PHY setting that matches the requested features mask
00db8189 Andy Fleming  2005-07-30  275   */
b73483ca Russell King  2017-01-05  276  static const struct phy_setting *
b73483ca Russell King  2017-01-05  277  phy_find_valid(int speed, int duplex, u32 supported)
00db8189 Andy Fleming  2005-07-30 @278  {
b73483ca Russell King  2017-01-05  279  	unsigned long mask = supported;
00db8189 Andy Fleming  2005-07-30  280  
b73483ca Russell King  2017-01-05  281  	return phy_lookup_setting(speed, duplex, &mask, BITS_PER_LONG, false);
00db8189 Andy Fleming  2005-07-30  282  }
00db8189 Andy Fleming  2005-07-30  283  
b3df0da8 Randy Dunlap  2007-03-06  284  /**
54da5a8b Guenter Roeck 2015-02-17  285   * phy_check_valid - check if there is a valid PHY setting which matches
54da5a8b Guenter Roeck 2015-02-17  286   *		     speed, duplex, and feature mask

:::::: The code at line 278 was first introduced by commit
:::::: 00db8189d984d6c51226dafbbe4a667ce9b7d5da This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.

:::::: TO: Andy Fleming <afleming@freescale.com>
:::::: CC: Jeff Garzik <jgarzik@pobox.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6421 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/f92d6b9a/attachment-0001.gz>
