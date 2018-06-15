From: msalter@redhat.com (Mark Salter)
Date: Fri, 15 Jun 2018 15:14:03 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <7a1768e2-bab5-c9f3-51b4-2131c9009498@infradead.org>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5120aa9f167c19712c01dc812f689eaef23bf0c5.camel@redhat.com>
 <7a1768e2-bab5-c9f3-51b4-2131c9009498@infradead.org>
Message-ID: <a42567729ff860fb9abf43575e1c21cac8e1df8a.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-15 at 11:15 -0700, Geoff Levand wrote:
> Hi Mark,
> 
> On 06/15/2018 10:33 AM, Mark Salter wrote:
> > On Fri, 2018-06-15 at 10:17 -0700, Geoff Levand wrote:
> > > > > +            MIDR_IMPLEMENTOR(read_cpuid_id()) == ARM_CPU_IMP_APM) {
> > > > 
> > > > How is the CPU implementer relevant?
> > > 
> > > That was just a copy of what other fixes had.  Should I remove it?
> > 
> > It was there because HPE ProLiant strings are generic and you may end up
> > disabling platforms which would otherwise work. It is the ProLiant system
> > based on the APM chipset which is the problem. Thus the check for cpu
> > implementor.
> 
> Your original fix that had this cpu implementor check was in the main
> ACPI code, so would be built for other arches.  This is now in
> arch/arm64/kernel/acpi.c, which will only be built for arm64.  Is that
> enough to limit it, or do we still need the check?

The original code was protected by #ifdef ARM64. But yes, HPE has announced
another aarch64 ProLiant system based on Cavium ThunderX2. So we need to
allow everything but the APM XGene based ProLiant products.
