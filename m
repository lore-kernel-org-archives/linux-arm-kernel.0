From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Jun 2017 17:04:36 +0800
Subject: [PATCH v3 1/3] spi: rockchip: add support for "cs-gpios" dts
 property
In-Reply-To: <1497411483-23377-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <201706141616.khtJ942K%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.12-rc5 next-20170613]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jeffy-Chen/spi-rockchip-add-support-for-cs-gpios-dts-property/20170614-160238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: x86_64-randconfig-x012-201724 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers//spi/spi-rockchip.c: In function 'rockchip_spi_probe':
>> drivers//spi/spi-rockchip.c:812:3: error: label 'err_free_dma_rx' used but not defined
      goto err_free_dma_rx;
      ^~~~

vim +/err_free_dma_rx +812 drivers//spi/spi-rockchip.c

   806			master->dma_rx = rs->dma_rx.ch;
   807		}
   808	
   809		ret = rockchip_spi_setup_cs_gpios(&pdev->dev);
   810		if (ret) {
   811			dev_err(&pdev->dev, "Failed to setup cs gpios\n");
 > 812			goto err_free_dma_rx;
   813		}
   814	
   815		ret = devm_spi_register_master(&pdev->dev, master);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30248 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/1ffd737a/attachment-0001.gz>
