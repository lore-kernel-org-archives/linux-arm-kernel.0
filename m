From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 19:19:28 +0000
Subject: [PATCH 13/17] ARM: pl01x debug code endian fix
In-Reply-To: <20130209120912.GG17833@n2100.arm.linux.org.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-14-git-send-email-ben.dooks@codethink.co.uk>
 <20130209120912.GG17833@n2100.arm.linux.org.uk>
Message-ID: <51194440.2050302@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/13 12:09, Russell King - ARM Linux wrote:
> On Fri, Feb 08, 2013 at 11:17:43PM +0000, Ben Dooks wrote:
>> +#ifdef __ARMEB__
>> +#define ARM_BE(x...) x
>> +#else
>> +#define ARM_BE(x..)
>
> Buggy.
>
>> +#endif
>
> Rather than littering the code with stuff like this, define it in one
> central place please, and include it where necessary.

I'll add this to arch/arm/include/asm/assembler.h

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
