From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 21 Jan 2015 17:02:41 +0100
Subject: [PATCH 1/3] spi/xilinx: Use automatic bus number on device tree
In-Reply-To: <1421855590-9210-2-git-send-email-ricardo.ribalda@gmail.com>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
 <1421855590-9210-2-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <54BFCDA1.4060205@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2015 04:53 PM, Ricardo Ribalda Delgado wrote:
> If there is more than one spi device on a device tree, the second one
> will fail to probe due to a duplicated bus_num.
 > [...]

This should already be fixed. See commit 4b153a2137c5 ("spi: xilinx: Use 
pdev->id instead of pdev->dev.id for the SPI bus number")[1]. If the device 
was registered using devicetree pdev->id is -1, so dynamic numbers will be used.

- Lars

[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-xilinx.c?id=4b153a2137c5d2914794c8944d78c731c1b0ae9d
