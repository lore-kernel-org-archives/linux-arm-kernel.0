From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 Nov 2015 00:50:08 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <alpine.LFD.2.20.1511251931050.22569@knanqh.ubzr> (Nicolas
 Pitre's message of "Wed, 25 Nov 2015 19:44:50 -0500 (EST)")
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
 <yw1x8u5lpqqz.fsf@unicorn.mansr.com>
 <alpine.LFD.2.20.1511251931050.22569@knanqh.ubzr>
Message-ID: <yw1x4mg9posf.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 26 Nov 2015, M?ns Rullg?rd wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> 
>> > 3) In fact I was wondering if the overhead of the branch and back is 
>> >    really significant compared to the non trivial cost of a idiv 
>> >    instruction and all the complex infrastructure required to patch 
>> >    those branches directly, and consequently if the performance 
>> >    difference is actually worth it versus simply doing (2) alone.
>> 
>> Depending on the operands, the div instruction can take as few as 3
>> cycles on a Cortex-A7.
>
> Even the current software based implementation can produce a result with 
> about 5 simple ALU instructions depending on the operands.
>
> The average cycle count is more important than the easy-way-out case. 
> And then how significant the two branches around it are compared to idiv 
> alone from direct patching of every call to it.

If not calling the function saves an I-cache miss, the benefit can be
substantial.  No, I have no proof of this being a problem, but it's
something that could happen.

Of course, none of this is going to be as good as letting the compiler
generate div instructions directly.

-- 
M?ns Rullg?rd
mans at mansr.com
