From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Mar 2012 16:42:36 -0500 (EST)
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler
 framework
In-Reply-To: <20120301130051.GE7363@n2100.arm.linux.org.uk>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
 <20120228192458.GC3617@n2100.arm.linux.org.uk>
 <20120301114942.GA2040@linaro.org>
 <20120301130051.GE7363@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1203021641340.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Mar 2012, Russell King - ARM Linux wrote:

> On Thu, Mar 01, 2012 at 11:49:42AM +0000, Dave Martin wrote:
> > Are you still interested in this series?
> > 
> > I have a workaround for the above now, but it's not pretty -- I seem to
> > have opened a can of worms here.
> > 
> > 
> > We would need something like
> > 
> > #define EXTENDED_ASM(stuff) asm ( ".include \"macros.inc\"\n\t" stuff )
> > #define EXTENDED_VASM(stuff) asm volatile ( ".include \"macros.inc\"\n\t" stuff )
> > 
> > ...where macros.inc includes some logic to protect against multiple
> > inclusion.
> > 
> > This would avoid problems caused by reordering done by the compiler.
> > 
> > I think this can work, but it may be a step too far...
> 
> I'm fairly tempted to say: "if it ain't broke, don't fix".  AFAIK no one
> has reported problems here, so lets not hastily try to fix something that
> will error out if it does go wrong.

OK, exactly what I said.

(I should have read further down the thread before replying)


Nicolas
