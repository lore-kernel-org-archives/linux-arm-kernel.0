From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 15 Jun 2017 10:40:29 +0800
Subject: [PATCH v3 1/3] spi: rockchip: add support for "cs-gpios" dts
 property
In-Reply-To: <201706141616.khtJ942K%fengguang.wu@intel.com>
References: <201706141616.khtJ942K%fengguang.wu@intel.com>
Message-ID: <5941F39D.2090503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys(and Robot(^.^)),

this is because i drop this patch:
9783131 New          [v2,1/4] spi: rockchip: fix error handling when probe

which is applied at 6/14, so not on v4.12-rc5 next-20170613.

On 06/14/2017 05:04 PM, kbuild test robot wrote:
> Hi Jeffy,
>
> [auto build test ERROR on rockchip/for-next]
> [also build test ERROR on v4.12-rc5 next-20170613]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jeffy-Chen/spi-rockchip-add-support-for-cs-gpios-dts-property/20170614-160238
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
> config: x86_64-randconfig-x012-201724 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>     drivers//spi/spi-rockchip.c: In function 'rockchip_spi_probe':
>>> drivers//spi/spi-rockchip.c:812:3: error: label 'err_free_dma_rx' used but not defined
>        goto err_free_dma_rx;
>        ^~~~
>
> vim +/err_free_dma_rx +812 drivers//spi/spi-rockchip.c
>
>     806			master->dma_rx = rs->dma_rx.ch;
>     807		}
>     808	
>     809		ret = rockchip_spi_setup_cs_gpios(&pdev->dev);
>     810		if (ret) {
>     811			dev_err(&pdev->dev, "Failed to setup cs gpios\n");
>   > 812			goto err_free_dma_rx;
>     813		}
>     814	
>     815		ret = devm_spi_register_master(&pdev->dev, master);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
