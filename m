From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 12 Jun 2014 10:55:32 +0200
Subject: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <20140612055358.GA30128@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE>
Message-ID: <xa1toaxyjym3.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:
>> 
>> > We don't need explicit 'CMA:' prefix, since we already define prefix
>> > 'cma:' in pr_fmt. So remove it.
>> >
>> > And, some logs print function name and others doesn't. This looks
>> > bad to me, so I unify log format to print function name consistently.
>> >
>> > Lastly, I add one more debug log on cma_activate_area().
>> >
>> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> >
>> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
>> > index 83969f8..bd0bb81 100644
>> > --- a/drivers/base/dma-contiguous.c
>> > +++ b/drivers/base/dma-contiguous.c
>> > @@ -144,7 +144,7 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>> >  	}
>> >
>> >  	if (selected_size && !dma_contiguous_default_area) {
>> > -		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>> > +		pr_debug("%s(): reserving %ld MiB for global area\n", __func__,
>> >  			 (unsigned long)selected_size / SZ_1M);

> On Thu, Jun 12, 2014 at 10:11:19AM +0530, Aneesh Kumar K.V wrote:
>> Do we need to do function(), or just function:. I have seen the later
>> usage in other parts of the kernel.

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> I also haven't seen this format in other kernel code, but, in cma, they use
> this format as following.
>
> function(arg1, arg2, ...): some message
>
> If we all dislike this format, we can change it after merging this
> patchset. Until then, it seems better to me to leave it as is.

I used ?function(arg1, arg2, ?)? at the *beginning* of functions when
the arguments passed to the function were included in the message.  In
all other cases I left it at just ?function:? (or just no additional
prefix).  IMO that's a reasonable strategy.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
