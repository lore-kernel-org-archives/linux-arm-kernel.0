From: mina86@mina86.com (Michal Nazarewicz)
Date: Sun, 05 Feb 2012 15:37:07 +0100
Subject: [PATCH 08/15] mm: mmzone: MIGRATE_CMA migration type added
In-Reply-To: <CAJd=RBD765rmiCDiCz87Vf8vf8Wp-AiW=gZ3Nw5LjTPw70ZO7g@mail.gmail.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-9-git-send-email-m.szyprowski@samsung.com>
 <CAJd=RBByc_wLEJTK66J4eY03CWnCoCRiwAeEYjXCZ5xEZhp3ag@mail.gmail.com>
 <op.v830ygma3l0zgt@mpn-glaptop>
 <CAJd=RBD765rmiCDiCz87Vf8vf8Wp-AiW=gZ3Nw5LjTPw70ZO7g@mail.gmail.com>
Message-ID: <op.v87mv5ca3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>> +static inline bool migrate_async_suitable(int migratetype)

>> On Fri, 03 Feb 2012 15:19:54 +0100, Hillf Danton <dhillf@gmail.com> wrote:
>>> Just nitpick, since the helper is not directly related to what async
>>> means, how about migrate_suitable(int migrate_type) ?

> 2012/2/3 Michal Nazarewicz <mina86@mina86.com>:
>> I feel current name is better suited since it says that it's OK to scan this
>> block if it's an asynchronous compaction run.

On Sat, 04 Feb 2012 10:09:02 +0100, Hillf Danton <dhillf@gmail.com> wrote:
> The input is the migrate type of page considered, and the async is only one
> of the modes that compaction should be carried out. Plus the helper is
> also used in other cases where async is entirely not concerned.
>
> That said, the naming is not clear, if not misleading.

In the first version the function was called is_migrate_cma_or_movable() which
described what the function checked.  Mel did not like it though, hence the
change to migrate_async_suitable().  Honestly, I'm not sure what would be the
best name for function.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
