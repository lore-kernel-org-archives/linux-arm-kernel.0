From: filip.zyzniewski@gmail.com (Filip Zyzniewski)
Date: Tue, 22 Dec 2009 17:33:30 +0100
Subject: DMA/cache problems on SA1110/SA1111 (Was: Re: USB Host on a SA1111)
Message-ID: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2009 at 10:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> Russell you got any clues on this? From my point of view it really should
>> just work. But Ive never done this myself.
>
> I've never really been that much involved with USB stuff, so can't really
> comment.
>

There was some discussion about this at linux-usb mailing list.
The interesting part is here:
http://thread.gmane.org/gmane.linux.usb.general/25732

Especially the last post by Alan Stern:

> I looked at one of these logs. ?Apparently there's a problem with the
> memory caching and DMA. ?With some of the commands, the debugging
> message shows incorrect data in the buffer. ?But later on, when the
> data gets used, it obviously is correct.
> This implies that something is wrong with the implementation of
> dma_map_single() or dma_unmap_unsingle(). ?And it might explain why
> changing the system's cache settings affects the behavior.

I don't know architecture handling details, could somebody more
knowledgeable give me
some clues about where to begin fixing this? What could be broken?

regards,
Filip Zyzniewski
