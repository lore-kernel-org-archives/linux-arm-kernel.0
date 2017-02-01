From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 08:58:22 +0800
Subject: [stericsson:mmc-no-NULL 15/20] drivers/mmc/core/block.c:1590:4:
 error: 'req_pending' undeclared
Message-ID: <201702010819.gNpPATry%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmc-no-NULL
head:   cbda9cc03b53855a310c144100f860d7e0876af4
commit: 1de4d40facb78ff9a305e149d8a468fc6596d78c [15/20] mmc: block: return errorcode from mmc_sd_num_wr_blocks()
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 1de4d40facb78ff9a305e149d8a468fc6596d78c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the stericsson/mmc-no-NULL HEAD cbda9cc03b53855a310c144100f860d7e0876af4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/mmc/core/block.c: In function 'mmc_blk_cmd_err':
>> drivers/mmc/core/block.c:1590:4: error: 'req_pending' undeclared (first use in this function)
       req_pending = blk_end_request(req, 0, blocks << 9);
       ^~~~~~~~~~~
   drivers/mmc/core/block.c:1590:4: note: each undeclared identifier is reported only once for each function it appears in

vim +/req_pending +1590 drivers/mmc/core/block.c

  1584		if (mmc_card_sd(card)) {
  1585			u32 blocks;
  1586			int err;
  1587	
  1588			err = mmc_sd_num_wr_blocks(card, &blocks);
  1589			if (!err) {
> 1590				req_pending = blk_end_request(req, 0, blocks << 9);
  1591			}
  1592		} else {
  1593			ret = blk_end_request(req, 0, brq->data.bytes_xfered);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38277 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/61431c45/attachment-0001.gz>
