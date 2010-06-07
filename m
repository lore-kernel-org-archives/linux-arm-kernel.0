From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 08 Jun 2010 00:09:43 +0100
Subject: Preload engine in ARMv7 (cortex A8)
References: <AANLkTilGu3OC_tth-Wurgu1jcm5zKKntINGc-A8CwkxI@mail.gmail.com>
	<1275901492.7258.6.camel@toshiba-laptop>
Message-ID: <yw1xk4qaxww8.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, 2010-06-01 at 18:27 +0100, Vinayak Pane wrote:
>> I am planning to utilize the PreLoad Engine for L2 cache. In past, I
>> have played with cache locking with line by line in ARM9. There I
>> could recall that tags and indexes are generated on basis of physical
>> address of the data. Now in case of PLE we have the start address and
>> number of lines to fill with. Does the PLE operation will leave some
>> indexes empty ? Or does the PLE populate all the lines in that way
>> with the source data address ? Do I need to start PLE for the block of
>> size equal to that of way-size ? To ensure no lines remain empty  and
>> to ensure no line gets overwriten by other line.
>
> I couldn't fully understand your question. It looks more like
> hardware-related (you could try support at arm.com).
>
> Anyway, in general you should not make any assumptions about which lines
> are present or not in the cache. With speculative loads on newer cores,
> you can get other lines in the cache than what you were expecting and
> they may evict some the you explicitly tried to preload.

Locking a cache way before loading it with the PLE would avoid
unrelated loads, speculative or otherwise, evicting the preloaded data
early.  This of course gets complicated quickly, so it's generally
better to not assume anything.  Cache is not TCM and should not be
treated as such.

-- 
M?ns Rullg?rd
mans at mansr.com
