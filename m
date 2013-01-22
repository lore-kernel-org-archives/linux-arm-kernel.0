From: pistol@cs.duke.edu (Valentin Pistol)
Date: Tue, 22 Jan 2013 12:11:11 -0500
Subject: ARM: hw_breakpoint mismatch breakpoint behaves unexpectedly like
 a match breakpoint on ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <20130122093102.GC12295@mudshark.cambridge.arm.com>
References: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
 <20130122093102.GC12295@mudshark.cambridge.arm.com>
Message-ID: <CAPfQmK+mwx39J5yWiLCTWbiFL=yL-rw=XZXRkOwGU_byQsDyQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The ptrace interface doesn't support mismatch breakpoints, and ignores those
> bits in the user request, hence why you see a normal breakpoint being
> created. Note that mismatch breakpoints are used internally for stepping
> over breakpoints set by perf.
>
> If you wanted to add single-step using mismatch breakpoints, I think we'd be
> better off re-introducing the SINGLESTEP ptrace request for ARM to use
> hw_breakpoints.

I noticed your old Feb 2011 post on SINGLESTEP being removed:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041408.html

So it was managing its own breakpoints and instruction decoding (like
gdb would) but didn't take advantage of either mismatch support or
hw_breakpoints?

Such support seems really useful and yet much more simple if mismatch
is supported.
I definitely would like to use the ptrace and hw-breakpoints interface
instead of avoiding and writing it from scratch, as it takes care of a
lot of details, for instance SMP and context switches, uninstalling
and installing the breakpoints as required.

I'm wondering how pervasive the required changes are to support
SINGLESTEP with mismatch breakpoints.
If you think it's a good idea I'm very willing to try and add-in such support.
Please let me know if there's some obvious issues about going forward
with this that you may be aware of.

Thanks so much!

Valentin
