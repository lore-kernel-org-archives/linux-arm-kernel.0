From: ananaza@iki.fi (Antti P Miettinen)
Date: Fri, 22 Feb 2013 11:04:04 +0200
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <874nmowhm1.fsf@amiettinen-lnx.nvidia.com> (Antti P. Miettinen's
 message of "Mon, 24 Sep 2012 00:32:06 +0300")
References: <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
 <20120515094010.GF10453@n2100.arm.linux.org.uk>
 <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
 <20120515101505.GG10453@n2100.arm.linux.org.uk>
 <20120515162851.GC16614@e102568-lin.cambridge.arm.com>
 <20120515163618.GH13860@n2100.arm.linux.org.uk>
 <20120515170534.GA17319@e102568-lin.cambridge.arm.com>
 <87sjaetmqv.fsf@amiettinen-lnx.nvidia.com>
 <20120920095431.GC4588@e102568-lin.cambridge.arm.com>
 <87lig4tmw1.fsf@amiettinen-lnx.nvidia.com>
 <874nmowhm1.fsf@amiettinen-lnx.nvidia.com>
Message-ID: <87liag67p7.fsf@amiettinen-lnx.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, coming back to an old thread:

Antti P Miettinen <ananaza@iki.fi> writes:
> Antti P Miettinen <ananaza@iki.fi> writes:
>> Hmm.. is the condition for cache coherence protocol then different from
>> TLB lookups? If C is cleared, is the cache available for snoops by other
>> cores? What happens if another core needs a dirty line in a cache that
>> has C cleared?
>
> Sorry - looks like you already answered this:
>> 2) as long as they are taking part in coherency (SMP bit set in ACTLR), all
>>    Cortex-A cores in a MP configuration with the SCTLR.C bit set can hit in
>>    the cache of a CPU that runs with the C bit cleared in SCTLR
>
> So other cores apparently can search the cache that has C bit
> cleared. The only clarification I still would need is whether this
> searching applies to also TLB fetches by other cores. So when you say:
>> .. TLB fetches cannot search the D-cache if the C bit in
>> SCTLR is clear on A9. ..
>
> you meant TLB fethes by the core that has it's C bit cleared. The TLB
> fetches by other cores will still search the cache just like any other
> coherence searches?

This did not get answered - are TLB fetches by sibling cores treated in
the same way as cache fetches? If core A has C bit cleared, is the cache
still available for TLB fetches by core B?

--
Antti P Miettinen
http://www.iki.fi/~ananaza/
