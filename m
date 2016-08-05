From: lkp@intel.com (kbuild test robot)
Date: Fri, 5 Aug 2016 10:35:17 +0800
Subject: [PATCH] arm64: Add workaround for Cavium erratum 26026
In-Reply-To: <20160804205707.GJ2151@rric.localdomain>
Message-ID: <201608051040.1WVSAIMI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.7 next-20160804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Richter/arm64-Add-workaround-for-Cavium-erratum-26026/20160805-083523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/cpu_errata.c:99:17: error: 'ARM64_HAS_NO_BCAST_TLBI' undeclared here (not in a function)
      .capability = ARM64_HAS_NO_BCAST_TLBI,
                    ^

vim +/ARM64_HAS_NO_BCAST_TLBI +99 arch/arm64/kernel/cpu_errata.c

    93		},
    94	#endif
    95	#ifdef CONFIG_CAVIUM_ERRATUM_26026
    96		{
    97		/* Cavium ThunderX, pass 1.x */
    98			.desc = "Cavium erratum 26026",
  > 99			.capability = ARM64_HAS_NO_BCAST_TLBI,
   100			MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
   101		},
   102	#endif

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28771 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160805/ce08aa2c/attachment-0001.obj>
