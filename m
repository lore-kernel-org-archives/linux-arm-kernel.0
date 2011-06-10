From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 10 Jun 2011 19:16:45 +0200
Subject: [PATCH 02/10] lib: genalloc: Generic allocator improvements
In-Reply-To: <20110610135217.701a2fd2@lxorguk.ukuu.org.uk>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<1307699698-29369-3-git-send-email-m.szyprowski@samsung.com>
	<20110610122451.15af86d1@lxorguk.ukuu.org.uk>
	<000c01cc2769$02669b70$0733d250$%szyprowski@samsung.com>
	<20110610135217.701a2fd2@lxorguk.ukuu.org.uk>
Message-ID: <op.vwvd972b3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2011 14:52:17 +0200, Alan Cox <alan@lxorguk.ukuu.org.uk>  
wrote:

>> I plan to replace it with lib/bitmap.c bitmap_* based allocator  
>> (similar like
>> it it is used by dma_declare_coherent_memory() and friends in
>> drivers/base/dma-coherent.c). We need something really simple for CMA  
>> area
>> management.
>>
>> IMHO allocate_resource and friends a bit too heavy here, but good to  
>> know
>> that such allocator also exists.
>
> Not sure I'd class allocate_resource as heavyweight but providing it's
> using something that already exists rather than inventing yet another
> allocator.

genalloc is already in the kernel and is used in a few places, so we
either let everyone use it as they see fit or we deprecate the library.
If we don't deprecate it I see no reason why CMA should not use it.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
