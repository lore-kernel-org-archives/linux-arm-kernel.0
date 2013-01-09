From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Jan 2013 16:12:31 -0700
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <201301092210.49452.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <201301092119.57067.arnd@arndb.de>
 <20130109215428.GA13648@avionic-0098.adnet.avionic-design.de>
 <201301092210.49452.arnd@arndb.de>
Message-ID: <50EDF95F.4070209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 03:10 PM, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Thierry Reding wrote:
>> What happens on Tegra is that we need to map 256 MiB of physical memory
>> to access all the PCIe extended configuration space. However, ioremap()
>> on such a large region fails if not enough vmalloc() space is available.
>>
>> This was observed when somebody tested this on CardHu which has a 1 GiB
>> of RAM and therefore remapping the full 256 MiB fails.
...
> Have you checked if the hardware supports an alternative config
> space access mechanism that does not depend on a huge address range?
> A lot of them provide an index/data register pair somewhere, as the
> original PC implementation did.

That would be nice, but I've talked to the HW engineers, and there's no
indication that any alternative mechanism exists.
