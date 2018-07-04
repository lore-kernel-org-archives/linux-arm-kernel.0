From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 17:09:09 +0100
Subject: [PATCHv4 05/10] arm64/cpufeature: detect pointer authentication
In-Reply-To: <20180525100137.mte5z2sonob3vffq@lakrids.cambridge.arm.com>
References: <20180503132031.25705-1-mark.rutland@arm.com>
 <20180503132031.25705-6-mark.rutland@arm.com>
 <4c057e99-61a9-7f75-664d-1f16f2631766@arm.com>
 <20180525100137.mte5z2sonob3vffq@lakrids.cambridge.arm.com>
Message-ID: <20180704160909.GR4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 11:01:37AM +0100, Mark Rutland wrote:
> On Wed, May 23, 2018 at 09:48:28AM +0100, Suzuki K Poulose wrote:
> > On 03/05/18 14:20, Mark Rutland wrote:
> > > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > > index bc51b72fafd4..9dcb4d1b14f5 100644
> > > --- a/arch/arm64/include/asm/cpucaps.h
> > > +++ b/arch/arm64/include/asm/cpucaps.h
> > > @@ -48,7 +48,10 @@
> > >   #define ARM64_HAS_CACHE_IDC			27
> > >   #define ARM64_HAS_CACHE_DIC			28
> > >   #define ARM64_HW_DBM				29
> > > +#define ARM64_HAS_ADDRESS_AUTH_ARCH		30
> > > +#define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		31
> > 
> > Where are these caps used ? I couldn't find anything in the series
> > that uses them. Otherwise looks good to me.
> 
> Those were consumed by KVM support, which needed to detect if CPUs had
> mismatched support. Currently they're just placeholders as I need a
> cpucap value for the separate IMP-DEF / architected probing cases.
> 
> I *could* get rid of those and just have the ARM64_HAS_ADDRESS_AUTH case
> log "Address authentication", but I wanted to have separate messages for
> IMP-DEF vs architected.

Why? Surely it only matters if we find a mixture, and then you'll shout
loudly. I'd certainly be in favour of reducing the number of caps you're
adding here, particularly if they're just there for a line in dmesg.

Will
