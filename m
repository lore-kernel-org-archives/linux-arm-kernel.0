From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 6 Dec 2009 10:13:26 -0600
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <alpine.LFD.2.00.0912061041310.31174@xanadu.home>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<771cded00912032141x368ae423n6603edbd7acd3f10@mail.gmail.com>
	<c70ff3ad0912060444nf65446ubce39029ca8b9247@mail.gmail.com>
	<alpine.LFD.2.00.0912061041310.31174@xanadu.home>
Message-ID: <c70ff3ad0912060813s767500a8q4561ec381413a609@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >> +__pj4_v6_proc_info:
>> >> + ? ? ? .long ? 0x560f5810
>> >> + ? ? ? .long ? 0xff0ffff0
>> >> + ? ? ? .long ? PMD_TYPE_SECT | \
>> >> + ? ? ? ? ? ? ? PMD_SECT_BUFFERABLE | \
>> >> + ? ? ? ? ? ? ? PMD_SECT_CACHEABLE | \
>> > These two flags are different from flags used in v6 proc_info. Is PJ4
>> > full compatible to armv6? Is there any reason to select
>> > PMD_SECT_BUFFERABLE & PMD_SECT_CACHEABLE at here?
>> good catch, those flags should be replace with PMD_FLAGS, this with
>> break SMP support according to the following commit:
>> "ARM: ensure initial page tables are setup for SMP systems"
>>
>> Nico, should I send a patch that deletes those flags or to resend the
>> updated patch?
>
> Please simply send a patch to fix it on top of what's already in the Git
> repo.
>
>
> Nicolas
>
Here it is:
---------------------------------------------------
