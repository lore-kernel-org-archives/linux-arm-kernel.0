From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 06:43:49 -0400
Subject: [RFC 01/23] ARM: LPAE: disable phys-to-virt patching on PAE
 systems
In-Reply-To: <20120724094143.GB20132@arm.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-2-git-send-email-cyril@ti.com>
 <20120724094143.GB20132@arm.com>
Message-ID: <500E7C65.6040502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 7/24/2012 5:41 AM, Catalin Marinas wrote:
> On Tue, Jul 24, 2012 at 02:09:03AM +0100, Cyril Chemparathy wrote:
>> From: Vitaly Andrianov <vitalya@ti.com>
>>
>> The current phys-to-virt patching mechanism is broken on PAE machines with
>> 64-bit physical addressing.  This patch disables the patching mechanism in
>> such configurations.
>
> It may be broken, I don't remember whether I tested this feature. What's
> the PHYS_OFFSET on your platform? Is it within the low 4GB range?
>

At boot time PHYS_OFFSET is 0x80000000, in the low 4G range. 
Subsequently we switch over to the high PHYS_OFFSET at 0x800000000 (see 
patch 23/23 of this series).

-- 
Thanks
- Cyril
