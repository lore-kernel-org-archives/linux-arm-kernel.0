From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Wed, 21 Jan 2015 17:51:19 +0100
Subject: [PATCH 1/3] spi/xilinx: Use automatic bus number on device tree
In-Reply-To: <54BFCDA1.4060205@metafoo.de>
References: <1421855590-9210-1-git-send-email-ricardo.ribalda@gmail.com>
 <1421855590-9210-2-git-send-email-ricardo.ribalda@gmail.com>
 <54BFCDA1.4060205@metafoo.de>
Message-ID: <CAPybu_2UqrAQ+a=9Luni12uvN8hfa9DFW8vtfGp+UE_VcMX_hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars

I think you are right. The other patches on the set are still valid though


Thanks!

On Wed, Jan 21, 2015 at 5:02 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/21/2015 04:53 PM, Ricardo Ribalda Delgado wrote:
>>
>> If there is more than one spi device on a device tree, the second one
>> will fail to probe due to a duplicated bus_num.
>
>> [...]
>
> This should already be fixed. See commit 4b153a2137c5 ("spi: xilinx: Use
> pdev->id instead of pdev->dev.id for the SPI bus number")[1]. If the device
> was registered using devicetree pdev->id is -1, so dynamic numbers will be
> used.
>
> - Lars
>
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-xilinx.c?id=4b153a2137c5d2914794c8944d78c731c1b0ae9d
>



-- 
Ricardo Ribalda
