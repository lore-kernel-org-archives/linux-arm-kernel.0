From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 28 May 2010 13:02:24 +0900
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <20100528035352.GO4720@trinity.fluff.org>
References: <20100528023559.GA8174@july>
	<20100528035352.GO4720@trinity.fluff.org>
Message-ID: <AANLkTikfCdHgzgRjVikeGYg5wK_meh3NyDRCOzs6j6uc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 28, 2010 at 12:53 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, May 28, 2010 at 11:35:59AM +0900, Kyungmin Park wrote:
>> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
>> Assume DMC0 starts with 0x2000'0000 with 128MiB.
>> DMC1 starts with 0x4000'0000 with 128MiB.
>> Note that DMC1 has to start address 0x4000'0000 at least.
>>
>> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
>>
>> To reduce memory waste, the DMC0 start with 0x3000'0000.

Hi,

>
> We should be using SPARSEMEM now, is it not reducing any wastage
> in virtual memory space?

Please consider the older kernel also. and most systems are designed
for 0x3000'0000.

>
> How will the user change their board to deal with this change to hte
> kernel?

Now we got the these memory
DMC0 has 128MiB and DMC1 has 512MiB.
Then it uses the memory from 0x2000'0000 to 0x5fff'ffff. it used 1GiB
memory address space.
Of course we can enable thie HIGHMEM but older kernel doesn't support it fully.
Also I hope to use the 3G/1G memory scheme.

How to you think?

Thank you,
Kyungmin Park
