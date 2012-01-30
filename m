From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 30 Jan 2012 13:33:06 +0100
Subject: [PATCH 05/15] mm: compaction: export some of the functions
In-Reply-To: <20120130115726.GI25268@csn.ul.ie>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-6-git-send-email-m.szyprowski@samsung.com>
 <20120130115726.GI25268@csn.ul.ie>
Message-ID: <op.v8wc5guk3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, Jan 26, 2012 at 10:00:47AM +0100, Marek Szyprowski wrote:
>> From: Michal Nazarewicz <mina86@mina86.com>
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -16,30 +16,11 @@
>>  #include <linux/sysfs.h>
>>  #include "internal.h"
>>
>> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
>> +

On Mon, 30 Jan 2012 12:57:26 +0100, Mel Gorman <mel@csn.ul.ie> wrote:
> This is pedantic but you reference CONFIG_CMA before the patch that
> declares it. The only time this really matters is when it breaks
> bisection but I do not think that is the case here.

I think I'll choose to be lazy on this one. ;) I actually tried to move
some commits around to resolve this future-reference, but this resulted
in quite a few conflicts during rebase and after several minutes I decided
that it's not worth the effort.

> Whether you fix this or not by moving the CONFIG_CMA check to the same
> patch that declares it in Kconfig
>
> Acked-by: Mel Gorman <mel@csn.ul.ie>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
