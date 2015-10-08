From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Oct 2015 14:51:00 +0800
Subject: [PATCH] mmc: core: Fix init_card in 52Mhz
In-Reply-To: <1444286462-23571-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <201510081423.MpXUr5VB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chaotian,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: i386-randconfig-i1-201540 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mmc/card/mmc_test.c: In function 'mmc_test_hw_reset':
>> drivers/mmc/card/mmc_test.c:2275:8: error: implicit declaration of function 'mmc_send_status' [-Werror=implicit-function-declaration]
     err = mmc_send_status(card, NULL);
           ^
   cc1: some warnings being treated as errors

vim +/mmc_send_status +2275 drivers/mmc/card/mmc_test.c

  2269		struct mmc_host *host = card->host;
  2270		int err;
  2271	
  2272		if (!mmc_card_mmc(card) || !mmc_can_reset(card))
  2273			return RESULT_UNSUP_CARD;
  2274	
> 2275		err = mmc_send_status(card, NULL);
  2276		if (err)
  2277			return err;
  2278	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20381 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151008/0670878a/attachment-0001.obj>
