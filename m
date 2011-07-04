From: heechul@illinois.edu (heechul Yun)
Date: Mon, 4 Jul 2011 07:59:59 -0700
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704094531.GB19117@e102109-lin.cambridge.arm.com>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
Message-ID: <CAN_5kQC3S+QB6MwNC0BUQ5_tqxrUmwKwN5pnPffBE=4V+9ZupQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2011 at 2:45 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Jul 01, 2011 at 10:42:00PM +0100, heechul Yun wrote:
>> Great.
>>
>> Removing the PTE flush seems to have a noticeable performance
>> difference in my test. The followings are lmbench 3.0a performance
>> result measured on a Cortex A9 SMP platform. So far, I did not have
>> any problem while doing various test.
>>
>> =========
>> mm-patch:
>> =========
>> Pagefaults on /tmp/XXX: 3.0759 microseconds
>> Process fork+exit: 464.5414 microseconds
>> Process fork+execve: 785.4944 microseconds
>> Process fork+/bin/sh -c: 488.6204 microseconds
>>
>> =========
>> original:
>> =========
>> Pagefaults on /tmp/XXX: 3.6209 microseconds
>> Process fork+exit: 485.5236 microseconds
>> Process fork+execve: 820.0613 microseconds
>> Process fork+/bin/sh -c: 2966.3828 microseconds
>
> Given these results, I think it's worth merging the patch. Can I add
> your Tested-by?

Yes you can.
I think this patch will be valuable for many applications (e.g.,
server applications).

Heechul

>
> I think there can be a few other optimisations in the TLB area but it
> needs some digging.
>
> Thanks.
>
> --
> Catalin
>
