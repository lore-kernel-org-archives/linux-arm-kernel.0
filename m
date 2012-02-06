From: dhillf@gmail.com (Hillf Danton)
Date: Mon, 6 Feb 2012 20:46:51 +0800
Subject: [PATCH 05/15] mm: compaction: export some of the functions
In-Reply-To: <op.v87mrdg83l0zgt@mpn-glaptop>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-6-git-send-email-m.szyprowski@samsung.com>
 <CAJd=RBBsTxV4bM_QEbKaU=uKkFTNgPEK4yTiLjbE0TaEp4KA7w@mail.gmail.com>
 <op.v87mrdg83l0zgt@mpn-glaptop>
Message-ID: <CAJd=RBAsRA-yggVSmijJPTLM2kKiLKWrTS9RjtESgPDc3pYTug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/5 Michal Nazarewicz <mina86@mina86.com>:
>> On Fri, Feb 3, 2012 at 8:18 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>>
>>> From: Michal Nazarewicz <mina86@mina86.com>
>>>
>>> This commit exports some of the functions from compaction.c file
>>> outside of it adding their declaration into internal.h header
>>> file so that other mm related code can use them.
>>>
>>> This forced compaction.c to always be compiled (as opposed to being
>>> compiled only if CONFIG_COMPACTION is defined) but as to avoid
>>> introducing code that user did not ask for, part of the compaction.c
>>> is now wrapped in on #ifdef.
>
>
> On Sun, 05 Feb 2012 08:40:08 +0100, Hillf Danton <dhillf@gmail.com> wrote:
>>
>> What if both compaction and CMA are not enabled?
>
>
> What about it? ?If both are enabled, both will be compiled and usable.
>

Better if enforced compilation of compaction is addressed in separate
patch in the patchset, according to the rule that one patch is delivered
with one issue concerned.
