From: lkp@intel.com (kbuild test robot)
Date: Sun, 3 Dec 2017 11:37:22 +0800
Subject: [PATCH net-next v4 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <1512090230-27594-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1512090230-27594-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <201712031142.jS4vt9Ur%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kunihiko,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/dt-bindings-net-add-DT-bindings-for-Socionext-UniPhier-AVE/20171203-095248
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/socionext/sni_ave.c: In function 'ave_pfsel_set_promisc':
>> drivers/net/ethernet/socionext/sni_ave.c:172:27: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define AVE_PFMBYTE_MASK0 (~GENMASK(7, 6))
                              ^
>> drivers/net/ethernet/socionext/sni_ave.c:1046:9: note: in expansion of macro 'AVE_PFMBYTE_MASK0'
     writel(AVE_PFMBYTE_MASK0, priv->base + AVE_PFMBYTE(entry));
            ^~~~~~~~~~~~~~~~~

vim +172 drivers/net/ethernet/socionext/sni_ave.c

   170	
   171	/* Packet filter */
 > 172	#define AVE_PFMBYTE_MASK0	(~GENMASK(7, 6))
   173	#define AVE_PFMBYTE_MASK1	GENMASK(25, 0)
   174	#define AVE_PFMBIT_MASK		GENMASK(15, 0)
   175	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52634 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171203/a3988e62/attachment-0001.gz>
