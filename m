From: ananaza@iki.fi (Antti P Miettinen)
Date: Wed, 19 Sep 2012 11:55:52 +0300
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
References: <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
 <20120515094010.GF10453@n2100.arm.linux.org.uk>
 <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
 <20120515101505.GG10453@n2100.arm.linux.org.uk>
 <20120515162851.GC16614@e102568-lin.cambridge.arm.com>
 <20120515163618.GH13860@n2100.arm.linux.org.uk>
 <20120515170534.GA17319@e102568-lin.cambridge.arm.com>
Message-ID: <87sjaetmqv.fsf@amiettinen-lnx.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> What we should do as I described, is executing the sequence:
>
> clear SCTRL.C
> clean cache
> exit coherency

How does SCTRL.C affect TLB fetches? Especially on A9? Seems that page
table updates do clean_dcache_area() so probably not an issue but just
out of curiosity, are TLB fetches affected by the C bit on A9?

--
Antti P Miettinen
http://www.iki.fi/~ananaza/
