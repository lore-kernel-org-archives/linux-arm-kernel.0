From: qiuxishi@huawei.com (Xishi Qiu)
Date: Tue, 12 Jan 2016 09:20:54 +0800
Subject: Have any influence on set_memory_** about below patch ??
In-Reply-To: <20160111133145.GM6499@leverpostej>
References: <5693A740.7070408@huawei.com> <20160111133145.GM6499@leverpostej>
Message-ID: <569454F6.1060207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/11 21:31, Mark Rutland wrote:

> Hi,
> 
> On Mon, Jan 11, 2016 at 08:59:44PM +0800, zhong jiang wrote:
>>
>> http://www.spinics.net/lists/arm-kernel/msg472090.html
>>
>> Hi, Can I ask you a question? Say, This patch tells that the section spilting
>> and merging wiil produce confilct in the liner mapping area. Based on the
>> situation, Assume that set up page table in 4kb page table way in the liner
>> mapping area, Does the set_memroy_** will work without any conplict??
> 
> I'm not sure I understand the question.
> 
> I'm also not a fan of responding to off-list queries as information gets
> lost.
> 
> Please ask your question on the mailing list. I am more than happy to
> respond there.
> 
> Thanks,
> Mark.
> 

Hi Mark,

In your patch it said "The presence of conflicting TLB entries may result in
a variety of behaviours detrimental to the system " and "but this(break-before-make
approach) cannot work for modifications to the swapper page tables that cover the
kernel text and data."

I'm not quite understand this, why the direct mapping can't work?
flush tlb can't resolve it?

I find x86 does not have this limit. e.g. set_memory_r*.

Thanks,
Xishi Qiu

> .
> 
