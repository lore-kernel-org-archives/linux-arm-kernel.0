From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 6 Jan 2012 14:56:52 +0100
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
In-Reply-To: <3197939.ZpLiSGWdou@ax5200p>
References: <1325719752-818-1-git-send-email-olof@lixom.net>
 <6121078.4q2inFFXlB@fb07-iapwap2>
 <CAD=FV=V3qO-=DOz5Qc95fyYJC4656WvmUYGXMAHgXcGf96+aeQ@mail.gmail.com>
 <3197939.ZpLiSGWdou@ax5200p>
Message-ID: <20230.64932.51663.410120@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietrich writes:
 > On Thursday 05 January 2012 10:40:48 Doug Anderson wrote:
 > > I can't comment on the L2 stuff (haven't looked there), but just going
 > > by Cortex-A9 revisions (T25 has roughly r1p1 and T30 has r2p7), I've
 > > got this table:
 > > 
 > > Errata             T25 (A9 ~r1p1)   T30 (A9 r2p7)    Applies to
 > > ARM_ERRATA_364296                                    pre A8
 > > ARM_ERRATA_411920                                    pre A8
 > > ARM_ERRATA_430973                                    A8
 > > ARM_ERRATA_458693                                    A8
 > > ARM_ERRATA_460075                                    A8
 > > ARM_ERRATA_720789  yes                               A9 (prior to r2p0)
 > > ARM_ERRATA_742230  yes                               A9 (r1p0..r2p2)
 > > ARM_ERRATA_742231                                    A9 (r2p0..r2p2)
 > > ARM_ERRATA_743622                                    A9 (r2p0..r2p2)
 > > ARM_ERRATA_751472  yes              yes              A9 (prior to r3p0)
 > > ARM_ERRATA_754322                   yes              A9 (r2p*, r3p*)
 > > ARM_ERRATA_754327  yes                               A9 (prior to r2p0)
 > > ARM_ERRATA_764369  yes              yes              A9 MPCore (all revs)
 > > 
 > > ...so that means we should also be adding in 720789 (T2x), 751472
 > > (T2x, T30), 754322 (T30), 754327 (T2x), 764369 (T2x, T30).
 > 
 > AFAIK, 720789 (TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty 
 > ASID) is fixed in userspace (or gcc) nowadays (at least in Ubuntu) so I think 
 > this can be neglected.

Not everyone uses Ubuntu.

Can you provide a reference to the corresponding gcc and/or Ubuntu patch?

(I got a Tegra-2 based trimslice last summer, but it's been completely
unreliable under load (hangs hard during "make -j2" gcc bootstraps),
hence I'm looking for patches or any other information that can help
me fix or work around whatever bugs it has.)
