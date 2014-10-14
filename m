From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 14 Oct 2014 17:18:55 +0100
Subject: [PATCHv2 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141001104002.4efbde6f@gandalf.local.home> (Steven Rostedt's
 message of "Wed, 1 Oct 2014 10:40:02 -0400")
References: <1412165279-8709-1-git-send-email-punit.agrawal@arm.com>
 <1412165279-8709-6-git-send-email-punit.agrawal@arm.com>
 <20141001104002.4efbde6f@gandalf.local.home>
Message-ID: <9hh8ukibp5c.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Correcting Arnd's email address ]

Hi Steve,

Thanks for having a look.

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed,  1 Oct 2014 13:07:59 +0100
> Punit Agrawal <punit.agrawal@arm.com> wrote:
>
>> Introduce an event to trace the usage of emulated instructions. The
>> trace event is intended to help identify and encourage the migration
>> of legacy software using the emulation features.
>> 
>> Use this event to trace usage of swp and CP15 barrier emulation.
>
> Do you expect this to be a generic tracepoint? Something any arch can
> use, and more importantly, will use?

The intention was to create a generic event to trace instruction
emulation irrespective of the architecture but at the moment the only
user will be arm64.

Whether other architectures start using it... I am not sure.

>
> If not, please keep this tracepoint in the arch/arm64 directories. The
> sample code in samples/trace_events/ explains how to do this.

I'll move this to arm64 in the next version.

>
> Thanks,
>
> -- Steve
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
