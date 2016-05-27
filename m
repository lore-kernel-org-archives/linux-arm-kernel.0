From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2016 14:36:25 +0100
Subject: [PATCH kexec-tools 18/32] arm: report if crash kernel is out of
 bounds
In-Reply-To: <CAHB_Guo-N0Coxj=fHBBM=QULMo6QK3uKbzOh15R6FCihGERjMA@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTQ-0004ih-NN@e0050434b2927.dyn.arm.linux.org.uk>
 <CAHB_Guo-N0Coxj=fHBBM=QULMo6QK3uKbzOh15R6FCihGERjMA@mail.gmail.com>
Message-ID: <20160527133624.GL19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 04:57:47PM +0530, Pratyush Anand wrote:
> On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> > diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
> > index 2dbde04..7314960 100644
> > --- a/kexec/arch/arm/crashdump-arm.h
> > +++ b/kexec/arch/arm/crashdump-arm.h
> > @@ -9,6 +9,7 @@ extern "C" {
> >  #define DEFAULT_PAGE_OFFSET            (0xc0000000)
> >  #define KVBASE_MASK    (0x1ffffff)
> >  #define CRASH_MAX_MEMORY_RANGES        32
> > +#define ARM_MAX_VIRTUAL                UINT32_MAX
> 
> If I see a kernel code then a virtual address is always defined as
> unsigned long. So, shouldn't we use ULONG_MAX instead?

What is the definition of ULONG_MAX?  The maximum unsigned value that
can fit in an unsigned long quantity.

While unsigned long _may_ be 32-bit, it's a very round-about way to
say "the maximum virtual address is the maximum unsigned 32-bit value".
Hence why I'm using UINT32_MAX here - it's a tighter and accurate
macro for what we're wanting.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
