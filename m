From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 May 2011 20:27:15 -0400
Subject: [PATCH] ftrace: recordmcount: avoid STT_FUNC symbols as base
	on ARM
In-Reply-To: <20110517225020.GD2266@n2100.arm.linux.org.uk>
References: <1305134631-31617-1-git-send-email-rabin@rab.in>
	<1305648629.5456.744.camel@gandalf.stny.rr.com>
	<20110517225020.GD2266@n2100.arm.linux.org.uk>
Message-ID: <1305678435.26849.0.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 23:50 +0100, Russell King - ARM Linux wrote:
> On Tue, May 17, 2011 at 12:10:29PM -0400, Steven Rostedt wrote:
> > On Wed, 2011-05-11 at 22:53 +0530, Rabin Vincent wrote:
> > > While find_secsym_ndx often finds the unamed local STT_SECTION, if a
> > > section has only one function in it, the ARM toolchain generates the
> > > STT_FUNC symbol before the STT_SECTION, and recordmcount finds this
> > > instead.
> > > 
> > > This is problematic on ARM because in ARM ELFs, "if a [STT_FUNC] symbol
> > > addresses a Thumb instruction, its value is the address of the
> > > instruction with bit zero set (in a relocatable object, the section
> > > offset with bit zero set)".  This leads to incorrect mcount addresses
> > > being recorded.
> > > 
> > > Fix this by not using STT_FUNC symbols as the base on ARM.
> > 
> > Hi Russell,
> > 
> > Can you give me an Acked-by on this patch?
> 
> It would be better for someone who knows the ELF format for ARM and
> its weirdnesses to ack this patch.  I'm afraid my ARM ELF format
> knowledge was been superseded when EABI came along and introduced
> all sorts of new stuff.

OK, in that case, I'll just apply the patch.

Thanks!

-- Steve
