From: ajay.gupta@ti.com (Gupta, Ajay Kumar)
Date: Tue, 29 Dec 2009 14:13:49 +0530
Subject: [PATCH RFC 1/2] MUSB: CPPI 4.1 DMA driver (take 4)
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044A2779F5@dbde02.ent.ti.com>
Message-ID: <19F8576C6E063C45BE387C64729E7394044A2779F6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Hello.
> Russell King - ARM Linux wrote:
>>>>Is there any updated patch on cppi4.1 core also?
>>>Is there _any_ cppi4.1 core patch anywhere?? Not according to google.
>>Russell,
>>Here is the latest ersion of cppi4.1 core.
>>http://patchwork.kernel.org/patch/46698/

>> [...]

>>>If it's a USB DMA device (from the patches I can find, that seems to be
>>>the case) then why can't it live in drivers/usb or drivers/dma ?
>>
>>CPPI4.1 DMA engine can be used either by USB or by Ethernet interface though
>>currently only USB is using it but in future even Ethernet devices may use it.

> drivers/dma does seem to be the right place for this.

>??? Russell, it makes me wonder why drivers/dma/ seemed the right place to 
> you, just because of the name? :-)
>??? After spending some time on studying the infrastructure there I came to 
> conclusion that this is not the right place because all the controllers 
> supported there have features like memory-to-memory transfers or even RAID 
> function offloading -- which CPPI 4.1 totally lacks (it's there purely to 
> serve the peripherals).
>??? Adding drivers/dma/ people to this discussion in hopes they can correct 
> me (or support me :-)...

As this discussion is taking time which is affecting the further
development and bug fixes on CPPI4.1. 

So can we move CPPI4.1 files to drivers/usb/musb for time being and submit
a replacement patch whenever we all agree on the location of CPPI4.1
related files.

-Ajay

> WBR, Sergei
> --
