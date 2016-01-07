From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 7 Jan 2016 10:47:50 +0530
Subject: dra7xx pci driver broken on dra7xx-evm
In-Reply-To: <20160106214518.GA6106@localhost.localdomain>
References: <20160106214518.GA6106@localhost.localdomain>
Message-ID: <568DF4FE.5010704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 07 January 2016 03:15 AM, Richard Cochran wrote:
> 
> The dra7xx-evm box freezes hard at the very first PCI bus access, the
> call to in dra7xx_pcie_readl() in dra7xx_pcie_probe().
> 
> The out-of-tree 3.14.53 TI driver performs a reset via platform data,
> calling omap_device_assert_hardreset() by hook and crook.
> 
> Adding the reset into the mainline driver cures the freeze.
> 
> Question: How on earth is this driver supposed to work?

It doesn't work out of the box in mainline. (Every time I post a PCI patch, I
add the pdata-quirks mechanism to test it). The pdata-quirks mechanism used in
TI tree is not an upstream-able solution. Something like this [1] was done for
performing reset. Not sure the latest state of that. Dan? Suman?

Thanks
Kishon

[1] -> https://patches.linaro.org/33797/
> 
> Thanks,
> Richard
> 
