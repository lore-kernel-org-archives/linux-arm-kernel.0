From: ananaza@iki.fi (Antti P Miettinen)
Date: Fri, 21 Sep 2012 00:17:18 +0300
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
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
Message-ID: <87lig4tmw1.fsf@amiettinen-lnx.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> On Wed, Sep 19, 2012 at 09:55:52AM +0100, Antti P Miettinen wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>> > What we should do as I described, is executing the sequence:
>> >
>> > clear SCTRL.C
>> > clean cache
>> > exit coherency
>> 
>> How does SCTRL.C affect TLB fetches? Especially on A9? Seems that page
>> table updates do clean_dcache_area() so probably not an issue but just
>> out of curiosity, are TLB fetches affected by the C bit on A9?
>
> Yes, they are. TLB fetches cannot search the D-cache if the C bit in
> SCTLR is clear on A9. I do not see any issue with this though, at least
> in the power down procedure described above and in previous e-mails in
> this thread.
>
> Lorenzo

Hmm.. is the condition for cache coherence protocol then different from
TLB lookups? If C is cleared, is the cache available for snoops by other
cores? What happens if another core needs a dirty line in a cache that
has C cleared?

--
Antti P Miettinen
http://www.iki.fi/~ananaza/
