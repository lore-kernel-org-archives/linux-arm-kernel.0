From: stefan@agner.ch (Stefan Agner)
Date: Wed, 17 Jun 2015 13:43:17 +0200
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <20150616223258.GW7557@n2100.arm.linux.org.uk>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
 <20150616223258.GW7557@n2100.arm.linux.org.uk>
Message-ID: <a2c7da075d7d1207f1316ee3069f59a2@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-17 00:32, Russell King - ARM Linux wrote:
> On Tue, Jun 16, 2015 at 11:51:47PM +0200, Stefan Agner wrote:
>> Add early fixmap support, initially to support permanent, fixed
>> mapping support for early console. A temporary, early pte is
>> created which is migrated to a permanent mapping in paging_init.
>> This is also needed since the attributes may change as the memory
>> types are initialized. The 3MiB range of fixmap spans two pte
>> tables, but currently only one pte is created for early fixmap
>> support.
>>
>> Re-add FIX_KMAP_BEGIN to the index calculation in highmem.c since
>> the index for kmap does not start at zero anymore. This reverts
>> 4221e2e6b316 ("ARM: 8031/1: fixmap: remove FIX_KMAP_BEGIN and
>> FIX_KMAP_END") to some extent.
> 
> Sorry, this isn't going to make the next merge window, I've closed my
> tree at the end of last week to new submissions (because it got too
> painful to maintain the for-next branch due to the number of cross-
> dependencies between branches.)  The only patches I'll entertain this
> week and throughout the merge window are bug fixes.

Ok no problem, I guess it's anyway a good idea to add it early in the
development cycle so the change gets a bit more testing coverage. Shall
I rebase the patch just after the merge window and send it out again or
add the patch in its current state to your patch tracker?

--
Stefan
