From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 12:42:04 +0100
Subject: [PATCH] atags_to_fdt: take into account root's #size and #cells
In-Reply-To: <20130619131117.2eb2260c@skate>
References: <1371639471-14144-1-git-send-email-ben.dooks@codethink.co.uk>
 <1371639471-14144-2-git-send-email-ben.dooks@codethink.co.uk>
 <20130619131117.2eb2260c@skate>
Message-ID: <51C1990C.8090906@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/13 12:11, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Wed, 19 Jun 2013 11:57:51 +0100, Ben Dooks wrote:
>> When creating entries for /memory, the root #size and #cells must be taken
>> into account otherwise the node will not be recongnized when the OF code
>> scans the nodes.
>>
>> On some systems, the default is now to be 2 for each of #size and #cells
>> which means that appending a kernrel and having it update from ATAGS does
>> not work properly.
>> ---
>>   arch/arm/boot/compressed/atags_to_fdt.c |   22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> Isn't this the same
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=faefd550c45d8d314e8f260f21565320355c947f
> which is already in linux-next?

Ah, it is almost the same although it only takes into
account the #size-cells but not the number of them.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
