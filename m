From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 May 2010 08:21:44 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100519014118.GD2318@shareable.org>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<20100519002826.GG25892@yookeroo> <20100519014118.GD2318@shareable.org>
Message-ID: <AANLkTik-9wjg0qGvqhn1dWhfLm-BAroHNWyU48jcrcqk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 7:41 PM, Jamie Lokier <jamie@shareable.org> wrote:
> David Gibson wrote:
>> On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
>> > On Tue, 18 May 2010, David Gibson wrote:
>> > > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
>> > > > Nicolas Pitre wrote:
>> [snip]
>> > > The only reason you'd need a subarchitecture number or equivalent is
>> > > if you need to do things differently in the very, very early asm boot
>> > > code. ?We may need a minimal form of this on PowerPC if we ever
>> > > support multiple MMU families in the same kernel binary.
>> >
>> > Exact. ?For example, on ARM the machine ID is also used to figure out
>> > the MMU mapping needed to be able to simply be able to debug the very
>> > early assembly boot stage when there isn't even a stack available. While
>> > this info is stored in the machine record, it is actually
>> > subarchitecture specific and already half-digested for easy usage by
>> > that initial MMU setup. ?I just don't want to imagine what the
>> > equivalent functionality with DT would look like.
>>
>> Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
>> walker to find and look up the compatible property. ?Quite possible
>> but, yes, fairly awkward.
>
> I'm not entirely clear, is the DT intended to replace the command line
> for saying things like "console=XXX"?

It doesn't replace the kernel parameters line, but the kernel
parameters line can be passed to the kernel via a property in the
/chosen node.  Firmware is allowed to modify the DT (ie. to change the
kernel parameters) before passing it to the kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
