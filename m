From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Oct 2013 12:06:00 +0000
Subject: [PATCH] ARM64: DT: define ARM64 specific arch_match_cpu_phys_id
In-Reply-To: <5270F042.6060600@arm.com>
References: <1382358582-32726-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <5270F042.6060600@arm.com>
Message-ID: <20131030120600.GH3975@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 11:40:50AM +0000, Sudeep KarkadaNagesha wrote:
> On 21/10/13 13:29, Sudeep KarkadaNagesha wrote:
> > From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > 
> > OF/DT core library provides architecture specific hook to match the
> > logical cpu index with the corresponding physical identifier.
> > 
> > On ARM64, the MPIDR_EL1 contains specific bitfields(MPIDR_EL1.Aff{3..0})
> > which uniquely identify a CPU, in addition to some non-identifying
> > information and reserved bits. The ARM cpu binding defines the 'reg'
> > property to only contain the affinity bits, and any cpu nodes with other
> > bits set in their 'reg' entry are skipped.
> > 
> > This patch overrides the weak definition of arch_match_cpu_phys_id
> > with ARM64 specific version using MPIDR_EL1.Aff{3..0} as cpu physical
> > identifiers.
> > 
> 
> Can you take this trivial patch for v3.13 ?

I will take it (missed it with the KS event).

Thanks.

-- 
Catalin
