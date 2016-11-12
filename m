From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Nov 2016 11:29:38 -0800
Subject: [PATCH RFC] mm: Add debug_virt_to_phys()
In-Reply-To: <20161112054318.GB24127@arm.com>
References: <20161112004449.30566-1-f.fainelli@gmail.com>
 <20161112054318.GB24127@arm.com>
Message-ID: <abb97b87-db44-e25a-608e-161b57a0439b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/11/2016 ? 21:43, Will Deacon a ?crit :
> On Fri, Nov 11, 2016 at 04:44:43PM -0800, Florian Fainelli wrote:
>> When CONFIG_DEBUG_VM is turned on, virt_to_phys() maps to
>> debug_virt_to_phys() which helps catch vmalloc space addresses being
>> passed. This is helpful in debugging bogus drivers that just assume
>> linear mappings all over the place.
>>
>> For ARM, ARM64, Unicore32 and Microblaze, the architectures define
>> __virt_to_phys() as being the functional implementation of the address
>> translation, so we special case the debug stub to call into
>> __virt_to_phys directly.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/include/asm/memory.h      |  4 ++++
>>  arch/arm64/include/asm/memory.h    |  4 ++++
>>  include/asm-generic/memory_model.h |  4 ++++
>>  mm/debug.c                         | 15 +++++++++++++++
>>  4 files changed, 27 insertions(+)
> 
> What's the interaction between this and the DEBUG_VIRTUAL patches from Laura?
> 
> http://lkml.kernel.org/r/20161102210054.16621-7-labbott at redhat.com
> 
> They seem to be tackling the exact same problem afaict.

Indeed thanks for pointing that out, I guess I could piggy back on this
patchset and try to cover ARM.

Thanks!
-- 
Florian
