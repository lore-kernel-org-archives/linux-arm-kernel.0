From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 22 May 2011 22:09:47 +0100
Subject: [PATCH v5 15/19] ARM: LPAE: Add support for
	cpu_v7_do_(suspend|resume)
In-Reply-To: <alpine.LFD.2.00.1105201407480.14430@xanadu.home>
References: <1304859098-10760-1-git-send-email-catalin.marinas@arm.com>
	<1304859098-10760-16-git-send-email-catalin.marinas@arm.com>
	<20110518072737.GC6815@atomide.com>
	<1305897667.2788.98.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105201407480.14430@xanadu.home>
Message-ID: <BANLkTimC7dC3P9NQC8BuED9HbdmP1nbZhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 May 2011 19:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 20 May 2011, Catalin Marinas wrote:
>> On Wed, 2011-05-18 at 08:27 +0100, Tony Lindgren wrote:
>> > Do we really need all this ifdef else throughout this series?
>> >
>> > I think we already have things in place to do this dynamically
>> > like we already do for thumb, smp_on_up, v6 vs v7 and so on.
>>
>> By dynamically, do you mean at run-time? We won't be able to compile
>> both classic and LPAE in the same kernel, there is just too much
>> difference between them (2 vs 3 levels of page tables - LPAE is an
>> entirely new format).
>>
>> If you mean some simpler macros like what we have for ARM/THUMB to
>> reduce the number of lines, I'm fine with it though we don't always have
>> a 1:1 mapping between LPAE and non-LPAE instructions.
>>
>> Alternatively, I'm happy to create a separate proc-v7lpae.S file.
>
> That would probably be the best option.

OK, I'll move this code to a separate file. The v7 setup code got
pretty hard to read.

-- 
Catalin
