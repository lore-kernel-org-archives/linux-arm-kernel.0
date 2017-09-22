From: vigneshr@ti.com (Vignesh R)
Date: Fri, 22 Sep 2017 14:32:18 +0530
Subject: [RESEND PATCH v2 2/5] mtd: spi-nor: cadence-quadspi: add a delay
 in write sequence
In-Reply-To: <201709221614.9GmeyqNH%fengguang.wu@intel.com>
References: <201709221614.9GmeyqNH%fengguang.wu@intel.com>
Message-ID: <5ba0a2f5-9dce-7d8a-6c94-3ac0355499dc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 22 September 2017 01:34 PM, kbuild test robot wrote:
> Hi Vignesh,
> 
> [auto build test WARNING on l2-mtd-boris/spi-nor/next]
> [also build test WARNING on v4.14-rc1 next-20170921]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vignesh-R/K2G-Add-QSPI-support/20170922-152110
> base:   git://git.infradead.org/l2-mtd.git spi-nor/next
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/mtd/spi-nor/cadence-quadspi.c: In function 'cqspi_probe':
>>> drivers/mtd/spi-nor/cadence-quadspi.c:1230:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      data  = (u32)of_device_get_match_data(&pdev->dev);
>              ^
> 

Oops, that should have been unsigned long. will send a v3 shortly.
Thanks for the report!



>   1219			dev_err(dev, "Cannot obtain IRQ.\n");
>   1220			return -ENXIO;
>   1221		}
>   1222	
>   1223		ret = clk_prepare_enable(cqspi->clk);
>   1224		if (ret) {
>   1225			dev_err(dev, "Cannot enable QSPI clock.\n");
>   1226			return ret;
>   1227		}
>   1228	
>   1229		cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> 1230		data  = (u32)of_device_get_match_data(&pdev->dev);
>   1231		if (data & CQSPI_NEEDS_WR_DELAY)


-- 
Regards
Vignesh
