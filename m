From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Mar 2018 14:46:08 +0800
Subject: [v2] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
In-Reply-To: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
References: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <201803231411.1XijNmJc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

I love your patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on next-20180322]
[cannot apply to linus/master v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roy-Pledge/staging-fsl-mc-Move-DPIO-from-staging-to-drivers-soc-fsl/20180323-102325
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from drivers/crypto/caam/sg_sw_sec4.h:14:0,
                    from drivers/crypto/caam/caamalg.c:55:
>> drivers/crypto/caam/sg_sw_qm2.h:38:10: fatal error: ../../../drivers/staging/fsl-mc/include/dpaa2-fd.h: No such file or directory
    #include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +38 drivers/crypto/caam/sg_sw_qm2.h

297b9ceb Horia Geant? 2017-07-18  37  
297b9ceb Horia Geant? 2017-07-18 @38  #include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
297b9ceb Horia Geant? 2017-07-18  39  

:::::: The code at line 38 was first introduced by commit
:::::: 297b9cebd2fc020f0bd3e0aac68b0758ab84e8d8 crypto: caam/jr - add support for DPAA2 parts

:::::: TO: Horia Geant? <horia.geanta@nxp.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64967 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180323/312a4afa/attachment-0001.gz>
