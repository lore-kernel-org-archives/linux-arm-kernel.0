From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 7 May 2015 15:31:03 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
References: <5538DD02.6050401@topic.nl>	<3382997.5hgfVKmNXP@wuerfel>	<5540D356.50708@topic.nl>	<9622793.RaVBbeJMCx@wuerfel>	<554B49F0.1090100@topic.nl>
 <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
Message-ID: <554B6917.40705@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 07-05-15 15:21, Daniel Drake wrote:
> On Thu, May 7, 2015 at 5:18 AM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
>> I reverted all my patches and workarounds. Indeed, the kernel needs a
>> "coherent" version of the dma_mmap routine, as the current version will map
>> it as non-cachable, resulting in a big performance hit (and nullifying the
>> whole idea behind it).
>>
>> I'll test it further on my 'hardware' and cook up a patch that correctly
>> maps the coherent pages.
>
> Sorry that I have only read this thread briefly, but I wonder if this
> is what you are looking for:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325489.html

It's related, but targets another use case. This one does the same in case the 
driver requested non-consistent memory.

My use case was that I have hardware implemented coherency (through ACP) so 
the CPU's and device's view on memory is already consistent, regardless of the 
status of the cache.

The patches are complimentary, not overlapping.

Thanks for the link though, it's something I was also looking into, as I don't 
always need coherency.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
