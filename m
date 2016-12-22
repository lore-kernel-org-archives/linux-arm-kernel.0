From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Dec 2016 02:49:23 +0800
Subject: [PATCH 11/12] crypto: atmel-authenc: add support to
 authenc(hmac(shaX),Y(aes)) modes
In-Reply-To: <2bf61b215c2c0729a20017cd8aa02cf99c5ddb1a.1482422983.git.cyrille.pitchen@atmel.com>
Message-ID: <201612230222.vuiFhBTm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

[auto build test ERROR on cryptodev/master]
[also build test ERROR on next-20161222]
[cannot apply to v4.9]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cyrille-Pitchen/crypto-atmel-authenc-add-support-to-authenc-hmac-shaX-Y-aes-modes/20161223-012130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

warning: (CRYPTO_DEV_ATMEL_AUTHENC) selects CRYPTO_DEV_ATMEL_SHA which has unmet direct dependencies (CRYPTO && CRYPTO_HW && ARCH_AT91)
>> drivers/crypto/atmel-aes.c:44:27: fatal error: atmel-authenc.h: No such file or directory
    #include "atmel-authenc.h"
                              ^
   compilation terminated.
--
>> drivers/crypto/atmel-sha.c:44:27: fatal error: atmel-authenc.h: No such file or directory
    #include "atmel-authenc.h"
                              ^
   compilation terminated.

vim +44 drivers/crypto/atmel-aes.c

    38	#include <crypto/aes.h>
    39	#include <crypto/xts.h>
    40	#include <crypto/internal/aead.h>
    41	#include <linux/platform_data/crypto-atmel.h>
    42	#include <dt-bindings/dma/at91.h>
    43	#include "atmel-aes-regs.h"
  > 44	#include "atmel-authenc.h"
    45	
    46	#define ATMEL_AES_PRIORITY	300
    47	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56834 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161223/40ee58c9/attachment-0001.gz>
