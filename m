From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 8 Jul 2016 11:57:10 -0400
Subject: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160708154824.ikq45dgk2auigqn7@treble>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
 <20160708145800.GE3556@pathway.suse.cz>
 <20160708150709.GA8979@lst.de>
 <20160708152421.GG3556@pathway.suse.cz>
 <20160708154824.ikq45dgk2auigqn7@treble>
Message-ID: <20160708115710.5c657b5f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2016 10:48:24 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:


> My understanding is that other arches don't need this check because they
> use -mfentry, so they have to modify the "call fentry" instruction to a
> nop on startup.
> 
> Here, with -fprolog-pad, it's already a nop, so no change is needed.
> 

That's what I was thinking. But as I stated in another email (probably
in the air when you wrote this), the call to ftrace_modify_code() may be
completely circumvented by ftrace_make_nop() if the addr is MCOUNT_ADDR.

-- Steve
