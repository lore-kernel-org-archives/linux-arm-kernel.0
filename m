From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Feb 2018 22:21:35 +0800
Subject: [PATCH v3 2/3] dmaengine: mediatek: Add MediaTek High-Speed DMA
 controller for MT7622 and MT7623 SoC
In-Reply-To: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
References: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
Message-ID: <201802032244.xa6YmxOG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15 next-20180202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/dt-bindings-dmaengine-Add-MediaTek-High-Speed-DMA-controller-bindings/20180203-203814
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/dma/mediatek/mtk-hsdma.c:19:0:
>> drivers/dma/mediatek/mtk-hsdma.c:880:25: error: 'mtk_dma_match' undeclared here (not in a function); did you mean 'mtk_hsdma_match'?
    MODULE_DEVICE_TABLE(of, mtk_dma_match);
                            ^
   include/linux/module.h:213:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                  ^~~~
>> include/linux/module.h:213:21: error: '__mod_of__mtk_dma_match_device_table' aliased to undefined symbol 'mtk_dma_match'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                        ^
>> drivers/dma/mediatek/mtk-hsdma.c:880:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, mtk_dma_match);
    ^~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/dma//mediatek/mtk-hsdma.c:19:0:
   drivers/dma//mediatek/mtk-hsdma.c:880:25: error: 'mtk_dma_match' undeclared here (not in a function); did you mean 'mtk_hsdma_match'?
    MODULE_DEVICE_TABLE(of, mtk_dma_match);
                            ^
   include/linux/module.h:213:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                  ^~~~
>> include/linux/module.h:213:21: error: '__mod_of__mtk_dma_match_device_table' aliased to undefined symbol 'mtk_dma_match'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                        ^
   drivers/dma//mediatek/mtk-hsdma.c:880:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, mtk_dma_match);
    ^~~~~~~~~~~~~~~~~~~

vim +880 drivers/dma/mediatek/mtk-hsdma.c

   874	
   875	static const struct of_device_id mtk_hsdma_match[] = {
   876		{ .compatible = "mediatek,mt7623-hsdma", .data = &mt7623_soc},
   877		{ .compatible = "mediatek,mt7622-hsdma", .data = &mt7622_soc},
   878		{ /* sentinel */ }
   879	};
 > 880	MODULE_DEVICE_TABLE(of, mtk_dma_match);
   881	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47952 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180203/0508ace0/attachment-0001.gz>
