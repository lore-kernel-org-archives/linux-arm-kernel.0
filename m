From: Hong.Xu@atmel.com (Xu, Hong)
Date: Tue, 18 Jan 2011 09:43:45 +0800
Subject: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
In-Reply-To: <4D34C5BF.2070107@bluewatersys.com>
References: <hong.xu@atmel.com>
	<1295248809-30334-2-git-send-email-hong.xu@atmel.com>
	<4D34A37E.1060300@bluewatersys.com>
	<4D34C5BF.2070107@bluewatersys.com>
Message-ID: <4C79549CB6F772498162A641D92D5328D9FE16@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,
> -----Original Message-----
> From: Ryan Mallon [mailto:ryan at bluewatersys.com]
> Sent: Tuesday, January 18, 2011 6:42 AM
> To: Xu, Hong
> Cc: linux-mtd at lists.infradead.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; jamie at jamieiles.com; jacmet at sunsite.dk;
> Ferre, Nicolas
> Subject: Re: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
> 
> root at snapper:~$ dmesg | grep -i dma
> [    0.850000] atmel_nand atmel_nand: Failed to request DMA channel
> [    0.860000] atmel_nand atmel_nand: No DMA support for NAND access.
> [    1.530000] at_hdmac at_hdmac: Atmel AHB DMA Controller ( cpy slave ),
> 8 channels
> 
> 
> It looks like the registration for the DMA controller happens after the
> NAND driver probe and so the request is failing. I had a quick look, but
> I can't see anything that would change this in more recent kernels. Any
> ideas?
> 
You got the point. A [Git Pull] has been sent, see
http://article.gmane.org/gmane.linux.kernel/1088240/match=dmaengine+update

In this patch, subsys_initcall will be used so DMA engine will be initialized before NAND driver.
Thanks.

BR,
Hong
