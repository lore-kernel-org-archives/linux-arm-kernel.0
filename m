From: lkp@intel.com (kbuild test robot)
Date: Sun, 11 Jun 2017 20:22:46 +0800
Subject: [PATCH v2 2/2] spi: mediatek: add spi support for mt7622 IC
In-Reply-To: <1497069989-30584-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <201706112011.OnVoVqgK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leilk,

[auto build test ERROR on spi/for-next]
[also build test ERROR on v4.12-rc4 next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Leilk-Liu/add-mt7622-spi-support/20170611-185202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> drivers//spi/spi-mt65xx.c:110:2: error: unknown field 'adjust_reg' specified in initializer
     .adjust_reg = true,
     ^

vim +/adjust_reg +110 drivers//spi/spi-mt65xx.c

   104	};
   105	
   106	static const struct mtk_spi_compatible mtk_common_compat;
   107	
   108	static const struct mtk_spi_compatible mt7622_compat = {
   109		.must_tx = true,
 > 110		.adjust_reg = true,
   111	};
   112	
   113	static const struct mtk_spi_compatible mt8173_compat = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50160 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170611/034ffdc6/attachment-0001.gz>
