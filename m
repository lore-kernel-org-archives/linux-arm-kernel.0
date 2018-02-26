From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Feb 2018 16:37:27 +0800
Subject: [PATCH 0.5/12] ARM: OMAP2+: Prepare to pass auxdata for
 smartreflex
In-Reply-To: <20180223214119.GB5593@atomide.com>
References: <20180223214119.GB5593@atomide.com>
Message-ID: <201802261623.teHicLDZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I love your patch! Yet something to improve:

[auto build test ERROR on omap/for-next]
[also build test ERROR on v4.16-rc3 next-20180226]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Lindgren/ARM-OMAP2-Prepare-to-pass-auxdata-for-smartreflex/20180226-132741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/mach-omap2/pdata-quirks.c:517:36: error: array type has incomplete element type 'struct omap_sr_data'
    struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
                                       ^~~~~~~~~~~~~

vim +517 arch/arm/mach-omap2/pdata-quirks.c

   516	
 > 517	struct omap_sr_data __maybe_unused omap_sr_pdata[OMAP_SR_NR];
   518	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43115 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/bc2b37ff/attachment-0001.gz>
