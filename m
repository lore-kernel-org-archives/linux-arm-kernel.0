From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Feb 2014 13:30:30 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140226175004.GC22839@e102568-lin.cambridge.arm.com>
References: <1393302345-18253-1-git-send-email-broonie@kernel.org>
 <1393302345-18253-2-git-send-email-broonie@kernel.org>
 <20140225165411.GA3883@red-moon>
 <20140226005052.GA31120@sirena.org.uk>
 <20140226123208.GB22839@e102568-lin.cambridge.arm.com>
 <20140226144610.GA2394@sirena.org.uk>
 <20140226154858.GC10246@arm.com>
 <20140226175004.GC22839@e102568-lin.cambridge.arm.com>
Message-ID: <20140227043030.GF9383@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 05:50:04PM +0000, Lorenzo Pieralisi wrote:

> What would be wrong, is leaving the core_sibling and thread_sibling
> masks empty and this CAN happen even on current arm32 code if the
> cluster id field (ie MPIDR[15:8] for the sake of this discussion) is
> different for different CPUs, and that's a bug that fortunately was
> never hit (it is a totally valid MPIDR layout, a bit weird though).

This is a good point, I will make sure any MPIDR code handles it (we
should fix the 32 bit code as well of course, I'll try to look at that
too).

> - if s topology node for a cpu (or some cpus) is missing or wrong, the whole
>   topology structure should be reverted to default (as in
>   include/linux/topology.h Documentation/cputopology.txt). This solves Mark's
>   concern about having some cpus with missing topology information.
>   NB: My patch does not do that, it resets topology only for the misconfigured
>   cpu.

I would certainly prefer this, I'll do an update (though not today,
trains again).

> That's the best we can do. I think that an MPIDR_EL1 fall back mechanism
> should be put in place, as a separate patch or squashed to patch 1.

> I would prefer the latter, but if you want to get the infrastructure in
> first I think that's acceptable.

I'd certainly prefer to get the code merged and work incrementally, it'd
make life easier to avoid having to manage the rebases.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/25c17ebc/attachment.sig>
