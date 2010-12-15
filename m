From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 14 Dec 2010 16:18:09 -0800
Subject: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
In-Reply-To: <20101214231922.GC14990@atomide.com> (Tony Lindgren's message of
	"Tue, 14 Dec 2010 15:19:23 -0800")
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<20101214231922.GC14990@atomide.com>
Message-ID: <87ipyvriri.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * G, Manjunath Kondaiah <manjugk@ti.com> [101203 19:33]:
>> *************************************************************************
>> 
>> Test Report:
>> ************
>> Build:
>> omap2plus_defconfig    : Success
>> omap_osk_5912_defconfig: Success
>> 
>> Boot:
>> OMAP3530Beagle         : Success
>> OMAP4430Blaze(ES2.1)   : Success
>
> Can you please make sure that memory to memory DMA test
> runs OK on OSK5912?x
>
> AFAIK, Kevin tried it a few days ago and it hung.

Yes, it hung, but I didn't have time to debug the root cause until
today.

The reason is that the OMAP1 DMA IRQ numbers used in mach-omap1/dma.c
have no basis in reality. So doing a memory-to-memory transfer using
*all* channels results in spurious interrupts, then hangs.

Will post details in reply to the OMAP1 patch (7/9). 

Kevin
