From: Hong.Xu@atmel.com (Xu, Hong)
Date: Tue, 18 Jan 2011 14:17:17 +0800
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBNVEQ6IGF0bWVsX25hbmQ6IEFkZCBETUEgcw==?=
	=?gb2312?B?dXBwb3J0IHRvIGFjY2VzcyBOYW5kZmxhc2g=?=
References: <hong.xu@atmel.com>
	<1295319406-5027-2-git-send-email-hong.xu@atmel.com>
	<4D350423.9040301@bluewatersys.com>
Message-ID: <4C79549CB6F772498162A641D92D532831AD28@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

 

Thanks for your careful review.

 

> -----Original Message-----

> From: Ryan Mallon [mailto:ryan at bluewatersys.com]

> Sent: Tuesday, January 18, 2011 11:08 AM

> To: Xu, Hong

> Cc: linux-mtd at lists.infradead.org; linux-arm-kernel at lists.infradead.org;

> linux-kernel at vger.kernel.org; jamie at jamieiles.com; jacmet at sunsite.dk;

> Ferre, Nicolas

> Subject: Re: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash

> 

> On 01/18/2011 03:56 PM, Hong Xu wrote:

> > Some SAM9 chips have the ability to perform DMA between CPU and SMC

> controller.

> > This patch adds DMA support for SAM9RL, SAM9G45, SSAM9G46,AM9M10, SAM9M11.

> >

> > Signed-off-by: Hong Xu <hong.xu@atmel.com>

> 

> Couple more notes below. I think the normal exit path for

> atmel_nand_dma_op needs to call dma_unmap_single. The other suggestions

> below are just stylistic.

> 

> Also, you still need a change to Kconfig to add the dependency on the

> AT_HDMAC driver otherwise users without that option selected will get

> build errors.

> 

 

Not all SAM9 chips have AT_HDMAC. I tried building the system successfully without

AT_HDMAC and even without DMADEVICES :-)

 

A new patch will be sent soon regarding to your other comments.

 

BR,

Hong

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110118/f0bd08b8/attachment-0001.html>
