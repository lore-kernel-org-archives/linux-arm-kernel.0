From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 02 Aug 2012 21:09:15 +0200
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <20120802185033.GA2725@mudshark.cambridge.arm.com> (Will Deacon's
 message of "Thu, 2 Aug 2012 19:50:33 +0100")
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
 <20120802130411.GU6802@n2100.arm.linux.org.uk>
 <20120802150123.GE9838@mudshark.cambridge.arm.com>
 <20120802153030.GV6802@n2100.arm.linux.org.uk>
 <20120802155140.GF9838@mudshark.cambridge.arm.com>
 <20120802181810.GW6802@n2100.arm.linux.org.uk>
 <20120802185033.GA2725@mudshark.cambridge.arm.com>
Message-ID: <87boit2js4.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Thu, Aug 02, 2012 at 07:18:10PM +0100, Russell King - ARM Linux wrote:
>> On Thu, Aug 02, 2012 at 04:51:41PM +0100, Will Deacon wrote:
>> > On Thu, Aug 02, 2012 at 04:30:30PM +0100, Russell King - ARM Linux wrote:
>> > > It might just be easier to specify something like -march=armv4 or
>> > > something like that, and then use .arch armv6 where required.
>> > 
>> > We could do that, but I worry that it will become very messy if/when people
>> > start adding things like virtualisation instructions (hvc and co) to the
>> > entry code. Using the same march flag for kernel and decompressor also keeps
>> > everything consistent.
>> 
>> But you're missing a fundamental point: the decompressor is not designed
>> to be built like that, it is designed to be built in such a way that it
>> works unmodified on any CPU type we have to date, whether you're building
>> a kernel for ARMv4 or ARMv7.
>> 
>> So, the code sequences which are architecture specific are only executed
>> after we've checked the ID registers to determine what we should be doing
>> for a particular CPU.
>
> That's fine, *if* we can persuade the tools to build the thing for us. With
> march=all, we got what we wanted but now that doesn't seem to work anymore.
>

and we already had to fix -march=all in the past :
http://sourceware.org/bugzilla/show_bug.cgi?id=12698

So maybe would be easier to try to fix it instead of trying to
workaround it ?

Arnaud
