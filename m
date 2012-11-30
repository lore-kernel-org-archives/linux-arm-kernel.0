From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 10:21:59 +0000
Subject: [PATCH v4 03/14] ARM: Factor out cpuid implementor and part number
In-Reply-To: <CANM98qLDLRdaOWWOU-zUs38+0A4YjSWLMUeuF=1KteFnyQyDsA@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154231.2836.24377.stgit@chazy-air>
 <20121119142126.GV3205@mudshark.cambridge.arm.com>
 <CANM98qLDLRdaOWWOU-zUs38+0A4YjSWLMUeuF=1KteFnyQyDsA@mail.gmail.com>
Message-ID: <20121130102159.GA26305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 09:38:46PM +0000, Christoffer Dall wrote:
> On Mon, Nov 19, 2012 at 9:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Nov 10, 2012 at 03:42:31PM +0000, Christoffer Dall wrote:
> >> Decoding the implementor and part number of the CPU id in the CPU ID
> >> register is needed by KVM, so we factor it out to share the code.
> >>
> >> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> >> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

[...]

> >> +static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
> >> +{
> >> +     return (read_cpuid_id() & 0xFF000000) >> 24;
> >> +}
> >> +
> >> +static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
> >> +{
> >> +     return (read_cpuid_id() & 0xFFF0);
> >> +}
> >
> > Perhaps this should take the implementor as an argument, given that the
> > part number is described differently between implementors. The xscale
> > stuff can then move in here (we'll need to check the xscale docs in case
> > perf is using a subfield -- I can't remember off-hand).

[...]

> > If you stick this one in a separate patch, I can take it via the perf
> > tree (along with the CPUID rework above).
> >
> thanks,
> I sent a separate patch.

Looks like we still have the ugly xscale cpuid parsing inline. Could you
move it as I suggested, please?

Will
