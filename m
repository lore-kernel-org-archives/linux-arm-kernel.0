From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 May 2012 12:11:06 +0100
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <201205101053.09954.arnd@arndb.de>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <201205092047.06852.arnd@arndb.de>
 <ed0ce2390716adbfc949f86c16dab996@localhost>
 <201205101053.09954.arnd@arndb.de>
Message-ID: <4FABA24A.9040209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/12 11:53, Arnd Bergmann wrote:
> On Wednesday 09 May 2012, Marc Zyngier wrote:
>>>
>>> Sounds good. I don't have a strong preference whether that should be a
>>> property like you suggest or a separate "compatible" value, maybe Rob or
>>> Grant can comment on what they prefer.
>>
>> At the moment, the compatible string should be pretty explicit, as it is
>> not possible to build an A7 or A15 based SoC without the virtualization
>> extensions.
> 
> Ok, makes sense. Then again, if you run an A15 guests on an A15 host,
> the virtual GIC would not have those extensions, right?

Indeed, they would be inaccessible (the hypervisor should not map them
into the guest address space). I'd expect the guest kernel not to try to
use them anyway, as it wouldn't be able to use the HYP mode.

But again, this is implementation specific.

	M.
-- 
Jazz is not dead. It just smells funny...
