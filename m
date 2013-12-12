From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 14:37:59 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212141926.GA31816@1wt.eu> (Willy Tarreau's message of "Thu,
 12 Dec 2013 15:19:26 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
Message-ID: <yw1xhaaejfso.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Willy Tarreau <w@1wt.eu> writes:

>> #include <stdint.h>
>> #include <stdio.h>
>> 
>> static inline uint32_t asm_add(uint16_t len, uint32_t sum)
>> {
>>         __asm__(
>>         "add    %0, %1, %2 \n"
>>         : "=&r"(sum)
>>         : "r" (sum), "r" (len)
>>         );
>>         return sum;
>> }
>
> Hmmm aren't you passing a 16-bit register directly to the ASM for being used
> as a 32-bit one ? This seems hasardous to me since nowhere you tell gcc how
> you're going to use the register.

There is no such thing as a 16-bit register on ARM.  What this code does
is ask the compiler to take the 16-bit value 'len' and put it in a register
for use in the asm code.  All registers are 32-bit, so there is no ambiguity.

-- 
M?ns Rullg?rd
mans at mansr.com
