From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 31 Mar 2011 18:26:45 +0200
Subject: [PATCH 05/12] mm: alloc_contig_range() added
In-Reply-To: <1301587361.31087.1040.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
	<1301587361.31087.1040.camel@nimitz>
Message-ID: <op.vs7umufd3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
>> +       ret = 0;
>> +       while (!PageBuddy(pfn_to_page(start & (~0UL << ret))))
>> +               if (WARN_ON(++ret >= MAX_ORDER))
>> +                       return -EINVAL;

On Thu, 31 Mar 2011 18:02:41 +0200, Dave Hansen wrote:
> Holy cow, that's dense.  Is there really no more straightforward way to
> do that?

Which part exactly is dense?  What would be qualify as a more
straightforward way?

> In any case, please pull the ++ret bit out of the WARN_ON().  Some
> people like to do:
>
> #define WARN_ON(...) do{}while(0)
>
> to save space on some systems.

I don't think that's the case.  Even if WARN_ON() decides not to print
a warning, it will still return the value of the argument.  If not,
a lot of code will brake.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
