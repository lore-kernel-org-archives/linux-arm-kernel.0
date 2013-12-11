From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 14:23:08 +0000
Subject: [PATCH 1/6] arm64: Add asm/cpu.h
In-Reply-To: <20131211141018.GC596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <20131211141018.GC596@darko.cambridge.arm.com>
Message-ID: <20131211142308.GY11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:10:19PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 01:13:21PM +0000, Mark Brown wrote:

> > +struct cpuinfo_arm {
> > +	struct cpu	cpu;
> > +	u64		cpuid;
> > +#ifdef CONFIG_SMP
> > +	unsigned int	loops_per_jiffy;
> > +#endif
> > +};

> How is this structure used? I haven't seen the ACPI code doing anything
> with struct cpu (though I haven't dug deep enough). Also loops_per_jiffy
> is useless, that's related to the delay loop based on the generic timer.

Now I look again we can probably drop this for the toplogy work - it had
been pulled in as part of pulling things in from pre-v8 and the cpuid
was used in the code while I was working on it but isn't any more unless
I'm misreading the code.  

I don't know what the ACPI guys are doing wtih it, I just saw they added
the same thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/7ca1e735/attachment.sig>
