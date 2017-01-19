From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 19 Jan 2017 21:08:42 +0800
Subject: [arm:phy-cleanup 10/10]
 arch/mips/cavium-octeon/octeon-platform.c:1064:15: error: expected
 declaration specifiers or '...' before string constant
Message-ID: <201701192138.NZ3q3lNY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy-cleanup
head:   ef8cb7d5f838770f22cae0e20fee8d1157fc88fd
commit: ef8cb7d5f838770f22cae0e20fee8d1157fc88fd [10/10] net: dsa: remove unnecessary phy*.h includes
config: mips-cavium_octeon_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ef8cb7d5f838770f22cae0e20fee8d1157fc88fd
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

>> arch/mips/cavium-octeon/octeon-platform.c:1064:15: error: expected declaration specifiers or '...' before string constant
    MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/cavium-octeon/octeon-platform.c:1065:16: error: expected declaration specifiers or '...' before string constant
    MODULE_LICENSE("GPL");
                   ^~~~~
   arch/mips/cavium-octeon/octeon-platform.c:1066:20: error: expected declaration specifiers or '...' before string constant
    MODULE_DESCRIPTION("Platform driver for Octeon SOC");
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +1064 arch/mips/cavium-octeon/octeon-platform.c

d617f9e9 David Daney   2013-12-03  1048  				break;
d617f9e9 David Daney   2013-12-03  1049  			default:
d617f9e9 David Daney   2013-12-03  1050  				break;
d617f9e9 David Daney   2013-12-03  1051  			}
d617f9e9 David Daney   2013-12-03  1052  		}
d617f9e9 David Daney   2013-12-03  1053  	}
d617f9e9 David Daney   2013-12-03  1054  
7ed18152 David Daney   2012-07-05  1055  	return 0;
7ed18152 David Daney   2012-07-05  1056  }
7ed18152 David Daney   2012-07-05  1057  
7ed18152 David Daney   2012-07-05  1058  static int __init octeon_publish_devices(void)
7ed18152 David Daney   2012-07-05  1059  {
7ed18152 David Daney   2012-07-05  1060  	return of_platform_bus_probe(NULL, octeon_ids, NULL);
7ed18152 David Daney   2012-07-05  1061  }
8074d782 Aaro Koskinen 2016-08-23  1062  arch_initcall(octeon_publish_devices);
7ed18152 David Daney   2012-07-05  1063  
512254ba David Daney   2009-09-16 @1064  MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
512254ba David Daney   2009-09-16  1065  MODULE_LICENSE("GPL");
512254ba David Daney   2009-09-16  1066  MODULE_DESCRIPTION("Platform driver for Octeon SOC");

:::::: The code at line 1064 was first introduced by commit
:::::: 512254ba8383c5dd7eca6819d0da1ce2fe9ede47 MIPS: Octeon:  Move some platform device registration to its own file.

:::::: TO: David Daney <ddaney@caviumnetworks.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 15852 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/93fef9e0/attachment-0001.gz>
