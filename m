From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 18 Jul 2016 15:07:57 +0300
Subject: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
In-Reply-To: <20160718103137.GG5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160718103137.GG5783@n2100.arm.linux.org.uk>
Message-ID: <5c538963-ae46-54fc-27bf-dbae81443215@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/16 13:31, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2016 at 03:42:35PM +0300, Peter Ujfalusi wrote:
>> Hi,
>>
>> The following series with the final patch will add support for sDMA Linked List
>> transfer support.
>> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
>> If the descriptor load feature is present we can create the descriptors for each
>> SG beforehand and let sDMA to walk them through.
>> This way the number of sDMA interrupts the kernel need to handle will drop
>> dramatically.
> 
> I suggested this a few years ago, and I was told by TI that there was
> no interest to implement this feature as it had very little performance
> effect.

I can not comment on this... Few years ago I was not involved with the DMA
drivers so I don't have any idea why would anyone object to have the linked
list (or descriptor load) mode in use whenever it is possible.
I was not even aware of the linked list mode of sDMA 3 weeks back, but while
reading the TRM - for the interleaved mode mainly it sounded like a good idea
to implement this.
Not really sure about the raw performance impact, but for interactivity it
does help. I remember running 'emerge --sync' on BeagleBoard was pain as it
took hours and the board was mostly unusable during that time. With the linked
list mode the same takes reasonable time and I can still poke around in the board.

> Do I take it that TI have changed their position on this feature?

I was not aware of any position on this from TI - as I mentioned I was not
involved with DMA. It could be that the position from 'TI' is still what it
was. Or changed. But as I have been asked to look after TI DMA drivers
upstream and I believe that the linked list mode is a good thing to have -
which is backed by my experiences. My position is that linked list support is
cool.

-- 
P?ter
