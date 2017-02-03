From: hekuang@huawei.com (Hekuang)
Date: Fri, 3 Feb 2017 19:08:53 +0800
Subject: [PATCH 2/2 v2] perf tools: Enable bpf prologue for arm64
In-Reply-To: <20170126193122.GB17504@kernel.org>
References: <20170124190908.GG10340@kernel.org>
 <20170125072311.22922-1-hekuang@huawei.com> <20170125133201.GC27026@arm.com>
 <20170126104916.971478fa29083cf4ae14fac3@kernel.org>
 <20170126165211.GK14167@arm.com> <20170126193122.GB17504@kernel.org>
Message-ID: <589464C5.5050205@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

? 2017/1/27 3:31, Arnaldo Carvalho de Melo ??:
> Em Thu, Jan 26, 2017 at 04:52:12PM +0000, Will Deacon escreveu:
>> On Thu, Jan 26, 2017 at 10:49:16AM +0900, Masami Hiramatsu wrote:
>>> On Wed, 25 Jan 2017 13:32:01 +0000
>>> Will Deacon <will.deacon@arm.com> wrote:
>>>
>>>> On Wed, Jan 25, 2017 at 07:23:11AM +0000, He Kuang wrote:
>>>>> Since HAVE_KPROBES can be enabled in arm64, this patch introduces
>>>>> regs_query_register_offset() to convert register name to offset for
>>>>> arm64, so the BPF prologue feature is ready to use.
>>>>>
>>>>> This patch also changes the 'dwarfnum' to 'offset' in register table,
>>>>> so the related functions are consistent with x86.
>>>> Wouldn't it be an awful lot simpler just to leave the code as-is, and
>>>> implement regs_query_register_offset in the same way that we implement
>>>> get_arch_regstr but return the dwarfnum?
>>> No, since the offset is not same as dwarfnum.
>>>
>>> With this style, the index of array becomes the dwarfnum (the index of
>>> each register defined by DWARF) and the "offset" member means the
>>> byte-offset of the register in (user_)pt_regs. Those should be different.
>> Ok, then do it as two patches then, rather than introduce functionality
>> along with the renaming.
>>
>>>> I don't really see the point of all the refactoring.
>>> Also, from the maintenance point of view, this rewrite work makes
>>> the code simply similar to x86 implementation, that will be easier to
>>> maintain :)
>> Right, apart from the two howling bugs in the version that was nearly merged
>> initially :p. I tend to err on the "if it ain't broke, don't fix it" side
>> of the argument but if you really want the refactoring lets keep it as a
>> separate change.
> So, He, can you do that? How do we proceed?
>
> - Arnaldo

I split the patch as Will suggested and resend them. Sorry for
late response, just back from Spring festival.
