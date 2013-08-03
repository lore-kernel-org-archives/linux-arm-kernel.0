From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Aug 2013 15:03:02 -0400
Subject: [PATCH v2 2/6] ARM: mm: Introduce virt_to_idmap() with an arch
 hook
In-Reply-To: <alpine.LFD.2.03.1308022153080.14472@syhkavp.arg>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-3-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022153080.14472@syhkavp.arg>
Message-ID: <51FD53E6.1070106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 August 2013 09:53 PM, Nicolas Pitre wrote:
> On Wed, 31 Jul 2013, Santosh Shilimkar wrote:
> 
>> On some PAE systems (e.g. TI Keystone), memory is above the
>> 32-bit addressable limit, and the interconnect provides an
>> aliased view of parts of physical memory in the 32-bit addressable
>> space.  This alias is strictly for boot time usage, and is not
>> otherwise usable because of coherency limitations. On such systems,
>> the idmap mechanism needs to take this aliased mapping into account.
>>
>> This patch introduces virt_to_idmap() and a arch function pointer which
>> can be populated by platform which needs it. Also populate necessary
>> idmap spots with now available virt_to_idmap(). Avoided #ifdef approach
>> to be compatible with multi-platform builds.
>>
>> Most architecture won't touch it and in that case virt_to_idmap()
>> fall-back to existing virt_to_phys() macro.
>>
>> Cc: Nicolas Pitre <nico@linaro.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
Thanks !!
