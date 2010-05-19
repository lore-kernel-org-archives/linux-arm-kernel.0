From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 19 May 2010 02:41:18 +0100
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100519002826.GG25892@yookeroo>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
	<alpine.LFD.2.00.1005180802010.12758@xanadu.home>
	<20100519002826.GG25892@yookeroo>
Message-ID: <20100519014118.GD2318@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Gibson wrote:
> On Tue, May 18, 2010 at 08:24:06AM -0400, Nicolas Pitre wrote:
> > On Tue, 18 May 2010, David Gibson wrote:
> > > On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
> > > > Nicolas Pitre wrote:
> [snip]
> > > The only reason you'd need a subarchitecture number or equivalent is
> > > if you need to do things differently in the very, very early asm boot
> > > code.  We may need a minimal form of this on PowerPC if we ever
> > > support multiple MMU families in the same kernel binary.
> > 
> > Exact.  For example, on ARM the machine ID is also used to figure out 
> > the MMU mapping needed to be able to simply be able to debug the very 
> > early assembly boot stage when there isn't even a stack available. While 
> > this info is stored in the machine record, it is actually 
> > subarchitecture specific and already half-digested for easy usage by 
> > that initial MMU setup.  I just don't want to imagine what the 
> > equivalent functionality with DT would look like.
> 
> Well, it wouldn't be *that* bad - you'd need a minimal asm-only tree
> walker to find and look up the compatible property.  Quite possible
> but, yes, fairly awkward.

I'm not entirely clear, is the DT intended to replace the command line
for saying things like "console=XXX"?

Real example: I have a device where the bootloader decides which
serial port will be the diagnostic boot console, if any, based on a
specially wired serial cable detected at boot time, and it passes the
decision to the kernel.

In that case, does the console selection need to be easily accessible
to that early asm code, for early printks?

-- Jamie
