From: damjan.marion@gmail.com (Damjan Marion)
Date: Fri, 24 Dec 2010 14:17:11 +0100
Subject: Bogus machine-type from bootloader
In-Reply-To: <20101224112908.GF20587@n2100.arm.linux.org.uk>
References: <BF43E57B-EE45-49B1-AE2A-96F8CBFD40FE@gmail.com>
	<20101224112908.GF20587@n2100.arm.linux.org.uk>
Message-ID: <BB8BA91F-29A3-46C5-A118-7ED736D7DBD4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 24, 2010, at 12:29 PM, Russell King - ARM Linux wrote:
> On Fri, Dec 24, 2010 at 12:19:25PM +0100, Damjan Marion wrote:
>> Is there any "proper" way if fixing bogus machine type sent by
>> bootloader (ofcourse except fixing bootloader itself)?
>> 
>> I'm looking into code where author did following:
>> 
>> 
>> +++ a/arch/arm/boot/compressed/head-str9100.S	2009-01-20 04:26:26.000000000 +0100
>> @@ -0,0 +1,7 @@
>> +#include <asm/mach-types.h>
>> +
>> +		.section	".start", "ax"
>> +
>> +__str9100_start:
>> +		mov	r7, #(MACH_TYPE_STR9100 & 0xFF00)
>> +		orr	r7, r7, #(MACH_TYPE_STR9100 & 0x00FF)
>> 
>> I assume this is not something acceptable for having in official kernel source.
> 
> From what I remember looking at the patch URL you posted, they also
> added entries for ID 2000 to their mach-types file, which have long
> since been taken by other people.

Yes, i fixed that

# bdinfo
arch_number = 0x00000CBA

but kernel still complains:

Error: unrecognized/unsupported machine ID (r1 = 0x00e6dca8).
