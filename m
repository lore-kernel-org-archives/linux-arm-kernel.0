From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Wed, 9 Jun 2010 12:26:13 +0800
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1006042212400.30664@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<201006050933.06714.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1006042212400.30664@xanadu.home>
Message-ID: <201006091226.15438.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> > If we're planning to keep the machine IDs around (even if they are now
> > per- SoC), I'd like to know what would be left using them. The only
> > thing that I can see that we currently use is io_pg_offset for the
> > DEBUG_LL builds, and that isn't a convincing case to keep them.
> 
> Why not?

Because it's something we can justifiably replace with a single compile-time 
constant, since it's only for low-level debug. I don't see that as a reason 
for keeping these machine numbers around if that's all they're used for.

However...

> Kernel infrastructure backward compatibility means that you need to keep
> struct machine_desc instances around.  Granted, for the DT case, many of
> the members could be NULL or initialized with dummy stubs.  But that is
> very cheap to keep around, and that allows the same kernel binary to be
> able to use both the DT boot and the legacy boot.

... this is a good point; if it helps with the transition, then this is 
probably a decent reason to keep it in the interface.

I'd like to keep my "only use the device tree" value (MACH_TYPE_DT = 
0xffffffff) though, so we don't needlessly allocate machine numbers where they 
aren't actually used.

Cheers,


Jeremy
