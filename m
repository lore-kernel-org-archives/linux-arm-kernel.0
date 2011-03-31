From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 31 Mar 2011 23:09:42 +0200
Subject: [PATCH 04/12] mm: alloc_contig_freed_pages() added
In-Reply-To: <1301587083.31087.1032.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-5-git-send-email-m.szyprowski@samsung.com>
	<1301587083.31087.1032.camel@nimitz>
Message-ID: <op.vs77qfx03l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Mar 2011 17:58:03 +0200, Dave Hansen <dave@linux.vnet.ibm.com>  
wrote:

> On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
>>
>> +unsigned long alloc_contig_freed_pages(unsigned long start, unsigned  
>> long end,
>> +                                      gfp_t flag)
>> +{
>> +       unsigned long pfn = start, count;
>> +       struct page *page;
>> +       struct zone *zone;
>> +       int order;
>> +
>> +       VM_BUG_ON(!pfn_valid(start));
>
> This seems kinda mean.  Could we return an error?  I understand that
> this is largely going to be an early-boot thing, but surely trying to
> punt on crappy input beats a full-on BUG().

Actually, I would have to check but I think that the usage of this function
(in this patchset) is that the caller expects the function to succeed.  It  
is
quite a low-level function so before running it a lot of preparation is  
needed
and the caller must make sure that several conditions are met.  I don't  
really
see advantage of returning a value rather then BUG()ing.

Also, CMA does not call this function at boot time.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
