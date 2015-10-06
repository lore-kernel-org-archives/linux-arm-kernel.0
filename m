From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 15:01:05 -0500
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <20151006193815.GI12338@codeaurora.org>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <56138485.4090600@free.fr>
 <20151006193815.GI12338@codeaurora.org>
Message-ID: <87k2qz22da.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 10/06, Mason wrote:
>> On 02/10/2015 20:02, Stephen Boyd wrote:
>> 
>> > The warning has been removed in commit 5028090d1da1 (ARM: 8434/1:
>> > Revert "7655/1: smp_twd: make twd_local_timer_of_register() no-op
>> > for nosmp", 2015-09-14) sitting in linux-next. Oddly, that commit
>> > doesn't remove the depends on SMP for the Kconfig. So it seems
>> > that we can apply this patch and everyone is happy? We could also
>> > drop the "if SMP" part of most of the platform selects if anyone
>> > actually cares.
>> > 
>> > ---8<----
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 369791fb619c..be64d9d604c3 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -1389,7 +1389,6 @@ config HAVE_ARM_ARCH_TIMER
>> >  
>> >  config HAVE_ARM_TWD
>> >  	bool
>> > -	depends on SMP
>> >  	select CLKSRC_OF if OF
>> >  	help
>> >  	  This options enables support for the ARM timer and watchdog unit
>> 
>> Hello Stephen,
>> 
>> Should I make a formal submission for the above patch to be accepted?
>
> No. I believe Felipe is going to update commit 5028090d1da1 to
> remove the depends on.

Already did it. Should be in next shortly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/5823d60b/attachment.sig>
