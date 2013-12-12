From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 15:50:45 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212154309.GR4360@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 12 Dec 2013 15:43:09 +0000")
References: <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
 <yw1xd2l2jflc.fsf@unicorn.mansr.com> <20131212150745.GB31816@1wt.eu>
 <yw1xsityhzd1.fsf@unicorn.mansr.com> <20131212152849.GC31816@1wt.eu>
 <20131212154309.GR4360@n2100.arm.linux.org.uk>
Message-ID: <yw1xob4mhxuy.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Dec 12, 2013 at 04:28:49PM +0100, Willy Tarreau wrote:
>> On Thu, Dec 12, 2013 at 03:18:18PM +0000, M?ns Rullg?rd wrote:
>> > The ABI for function calls sign/zero-extends all arguments prior to the
>> > call.
>> 
>> OK then that's pretty clear, there's no ambiguity, thanks for the precision.
>
> Let's be clear about this: there is no GCC bug here - the kernel code
> unfortunately what is buggy.  asm() input arguments are not subject to
> this promotion irrespective of the ABI.

At the asm() the value should already have been zero-extended.  Since
the code does not do anything with undefined behaviour, the fact that
different optimisation levels give different results clearly indicates a
compiler bug.

-- 
M?ns Rullg?rd
mans at mansr.com
