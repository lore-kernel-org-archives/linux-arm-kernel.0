From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 15:31:43 -0400
Subject: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with
 EMIF spec
In-Reply-To: <87fvukhwtv.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-5-git-send-email-d-gerlach@ti.com>
 <87fvukhwtv.fsf@kernel.org>
Message-ID: <5203F21F.3010801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 August 2013 02:16 PM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
> 
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> SDRAM controller on AM33XX requires that a modification of certain
>> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
>> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
>> scenario arises when entering a low power state like DeepSleep.
>> To ensure that the read is not from a cached region we reserve
>> some memory during bootup using the arm_memblock_steal() API.
> 
> Hmm, sounds to me an awful lot like the existing omap_bus_sync() ?
>
All the credit of that awful omap_bus_sync() goes to me since 
I introduced it. And I keep beating the hardware guys
who have not left a choice but to introduce the ugly work
around in software. ;-)

Regards,
Santosh
 
