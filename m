From: stefan@agner.ch (Stefan Agner)
Date: Sun, 04 Sep 2016 16:31:40 -0700
Subject: [PATCH] ARM: LPAE: initialize cachepolicy correctly
In-Reply-To: <20160904220903.GN1041@n2100.armlinux.org.uk>
References: <20160904053331.7264-1-stefan@agner.ch>
 <20160904220903.GN1041@n2100.armlinux.org.uk>
Message-ID: <eb470e86a233b7bc8328c820527f53c1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-04 15:09, Russell King - ARM Linux wrote:
> On Sat, Sep 03, 2016 at 10:33:31PM -0700, Stefan Agner wrote:
>> The cachepolicy variable gets initialized using a masked pmd
>> So far, the pmd has been masked with flags valid for the 2-page
>> table format. In the LPAE case, this lead to a wrong assumption
>> of what the initial cachepolicy has been used. Later a check
>> forces the cache policy to writealloc and prints the following
>> warning:
>> Forcing write-allocate cache policy for SMP
>>
>> This patch uses PMD_SECT_WBWA to mask all cache setting flags.
>> The define represents the complete mask of the cache relevant
>> flags for both page table formats.
> 
> PMD_SECT_WBWA is just one possible combination, it's not a bit-mask.
> We need a new definition.

Agreed, it just happens to be the same as the bit-mask in both
page-table layouts.

Does PMD_SECT_CACHE_MASK sounds like a reasonable identifier for it?

--
Stefan
