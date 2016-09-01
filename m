From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Sep 2016 19:31:45 +0800
Subject: [PATCH 1/2 v2] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <20160901093904.26564-1-sr@denx.de>
Message-ID: <201609011930.BQGnLcb2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Stefan-Roese/bus-mvebu-mbus-Provide-stub-function-for-mvebu_mbus_get_io_win_info/20160901-174432
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from drivers/ata/ahci_mvebu.c:16:0:
   include/linux/mbus.h: In function 'mvebu_mbus_get_io_win_info':
>> include/linux/mbus.h:79:10: error: 'EINVAL' undeclared (first use in this function)
     return -EINVAL;
             ^
   include/linux/mbus.h:79:10: note: each undeclared identifier is reported only once for each function it appears in

vim +/EINVAL +79 include/linux/mbus.h

    73		 * On all ARM32 MVEBU platforms with MBus support, this stub
    74		 * function will not get called. The real function from the
    75		 * MBus driver is called instead. ARM64 MVEBU platforms like
    76		 * the Armada 3700 could do use the mv_xor device which calls
    77		 * into this function
    78		 */
  > 79		return -EINVAL;
    80	}
    81	#endif
    82	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/3de94e7f/attachment-0001.obj>
