From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 24 Apr 2012 16:27:14 +0530
Subject: [PATCH 3/8] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
In-Reply-To: <20120424105045.GD25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk> <4F9681F1.2090408@nvidia.com>
 <20120424105045.GD25053@n2100.arm.linux.org.uk>
Message-ID: <4F96870A.5060303@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 April 2012 04:20 PM, Russell King - ARM Linux wrote:
>
>> For cyclic case, we will not like to call the  dma_cookie_complete() but
>> want to put the desc in callback list.
>> So can we have one more arg on this function which byspass the call of
>> dma_cookie_complete()
> See the discussion on what's supposed to happen with cyclic transfers.
> Cyclic transfers don't complete, so adding them to the completed list
> and marking them complete is the wrong thing to be doing.  So arguably
> calling this function is also the wrong thing to be doing because
> you're not completing the transfer.

OK, we will not call this function but still need to call the callback. 
So do you suggest to call callback directly from dma driver rather than 
the virt_chan?
> I'll be addressing the issue of cyclic transfers when I eventually get
> to sorting out the OMAP ASoC driver.

Here I am developing the dma driver for Tegra in cyclic and normal mode 
and what is your suggestion here?
Should I use your virt_chan now or I can go ahead with my first patch 
without virt_chan and once you are done with your virt_chan with all 
cyclic support then  port the tegra_dma to use virt chan and next 
enhanced patch?

In this way, my Tegra dma will be there in tree, all client will be move 
to dma engine based driver and then I will comeback to tegra_dma for 
using the virt_channel.
