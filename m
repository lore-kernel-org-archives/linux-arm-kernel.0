From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Feb 2014 23:04:34 +0000
Subject: [PATCH v4 0/6] generic early_ioremap support
In-Reply-To: <530CF21E.1020603@zytor.com>
References: <1392238575-10000-1-git-send-email-msalter@redhat.com>
 <1393337404.7307.51.camel@deneb.redhat.com>
 <20140225183012.GA27164@mudshark.cambridge.arm.com>
 <1393353942.26583.10.camel@deneb.redhat.com> <530CF21E.1020603@zytor.com>
Message-ID: <5D4B48CE-46BA-44E8-BCDE-AEACAC9973AF@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 Feb 2014, at 19:42, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/25/2014 10:45 AM, Mark Salter wrote:
>> On Tue, 2014-02-25 at 18:30 +0000, Will Deacon wrote:
>>> I'd suggest spitting the core part out from the arch-specific parts. That
>>> way, the core part can merged independently and architectures can move over
>>> as they see fit. It also signals (at least to me) that, "hey, I should
>>> probably review this" whilst my current stance is "there's a whole load of
>>> stuff under mm/ that needs to be acked first".
>>> 
>>> If you put the whole thing into next, you just run the risk of conflicts
>>> with all the arch trees.
>> 
>> I've been thinking of breaking out the common bits and x86 bits and just
>> going with that for now. There's no point in just doing the common bits
>> because it won't get tested without at least one architecture using it.
>> 
> 
> If you think it makes sense we could take the common bits + x86 and put
> them through the -tip tree.  

I?m ok with the arm64 patches to go through -tip with my ack on all
patches:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> The other option would be to put the whole
> thread in linux-next with Acks.
> 
> As far as x86 is concerned it looks like it is mostly just code
> movement, so I'm happy giving my:
> 
> Acked-by: H. Peter Anvin <hpa@linux.intel.com>

Thanks. Either way works for me.

I think the series still need an ack from rmk at least on the arm patch
(4/6).

Catalin
