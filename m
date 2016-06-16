From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 17 Jun 2016 03:52:16 +0800
Subject: [nomadik:pl08x-dma-mmc-sync-callback 5/5]
 drivers/mmc/host/mmci.c:1023:4: error: implicit declaration of function
 'mmci_dma_dataend_irq'
Message-ID: <201606170314.U9EkgGiz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git pl08x-dma-mmc-sync-callback
head:   42839b1b23fb2248fb6d305bfe956a1da8775392
commit: 42839b1b23fb2248fb6d305bfe956a1da8775392 [5/5] MMC uglyhack
config: arm-realview_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 42839b1b23fb2248fb6d305bfe956a1da8775392
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/mmc/host/mmci.c: In function 'mmci_data_irq':
>> drivers/mmc/host/mmci.c:1023:4: error: implicit declaration of function 'mmci_dma_dataend_irq' [-Werror=implicit-function-declaration]
       mmci_dma_dataend_irq(host);
       ^
   drivers/mmc/host/mmci.c: At top level:
   drivers/mmc/host/mmci.c:226:13: warning: 'mmci_dump_sg' defined but not used [-Wunused-function]
    static void mmci_dump_sg(struct mmc_data *data)
                ^
   cc1: some warnings being treated as errors

vim +/mmci_dma_dataend_irq +1023 drivers/mmc/host/mmci.c

  1017	
  1018		if (status & MCI_DATABLOCKEND)
  1019			dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
  1020	
  1021		if (status & MCI_DATAEND || data->error) {
  1022			if (dma_inprogress(host))
> 1023				mmci_dma_dataend_irq(host);
  1024			mmci_stop_data(host);
  1025	
  1026			if (!data->error) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 17260 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160617/fd7b3fc3/attachment-0001.obj>
