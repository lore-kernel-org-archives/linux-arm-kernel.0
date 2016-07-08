From: duwe@lst.de (Torsten Duwe)
Date: Fri, 8 Jul 2016 22:24:55 +0200
Subject: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160708115710.5c657b5f@gandalf.local.home>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
 <20160708145800.GE3556@pathway.suse.cz>
 <20160708150709.GA8979@lst.de>
 <20160708152421.GG3556@pathway.suse.cz>
 <20160708154824.ikq45dgk2auigqn7@treble>
 <20160708115710.5c657b5f@gandalf.local.home>
Message-ID: <20160708202455.GA4580@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:57:10AM -0400, Steven Rostedt wrote:
> On Fri, 8 Jul 2016 10:48:24 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > Here, with -fprolog-pad, it's already a nop, so no change is needed.
> > 

Yes, exactly.

> That's what I was thinking. But as I stated in another email (probably
> in the air when you wrote this), the call to ftrace_modify_code() may be
> completely circumvented by ftrace_make_nop() if the addr is MCOUNT_ADDR.

Only on the _first_ invocation. Later on, tracing can be switched on and off,
and then the instructions need to be changed just like with fentry (or
profile-kernel ;-)

	Torsten
