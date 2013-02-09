From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat, 09 Feb 2013 16:55:27 +0000
Subject: [PATCH 04/17] ARM: Add =?UTF-8?Q?ARCH=5FSUPPORTS=5FBIG=5FENDI?=
 =?UTF-8?Q?AN?=
In-Reply-To: <20130209115519.GB17833@n2100.arm.linux.org.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-5-git-send-email-ben.dooks@codethink.co.uk>
 <20130209115519.GB17833@n2100.arm.linux.org.uk>
Message-ID: <76480fe39adbb8e1538bc80aa9d6458e@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 11:55, Russell King - ARM Linux wrote:
> On Fri, Feb 08, 2013 at 11:17:34PM +0000, Ben Dooks wrote:
>> Add ARCH_SUPPORTS_BIG_ENDIAN define to arch/arm/Kconfig. Since it 
>> used
>> to live in arch/arm/mach-ixp4xx/Kconfig we move it up to the ARM one
>> as the next best place for it.
>>
>> It may be that it could be moved to a more generic location, with 
>> the
>> other ARCH_SUPPORT functions.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> So in patch 3, you remove this option (which removes it from the 
> generated
> configs) and add it back in in the following patch.  This makes this 
> series
> non-bisectable.  Please roll this into patch 3 and update the patch
> description accordingly.
>
> I'd also suggest moving it to arch/arm/mm/Kconfig rather than
> arch/arm/Kconfig, just before its only user, CPU_BIG_ENDIAN.

I was wondering if it should go elsewhere for other archs to use,
but arch/arm/mmk/Kconfig seems reasonable. We always move it later.

-- 
Ben
