From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 May 2013 10:52:17 +0100
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <20130507093508.GL23285@pengutronix.de>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
 <20130506093059.GH23285@pengutronix.de>
 <20130507092209.GD25387@mudshark.cambridge.arm.com>
 <20130507093508.GL23285@pengutronix.de>
Message-ID: <20130507095217.GG25387@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 10:35:08AM +0100, Uwe Kleine-K?nig wrote:
> Hello Will,

Hello,

> On Tue, May 07, 2013 at 10:22:09AM +0100, Will Deacon wrote:
> > On Mon, May 06, 2013 at 10:30:59AM +0100, Uwe Kleine-K?nig wrote:
> > > +#elif defined(CONFIG_CPU_V7M)
> > > +
> > > +#include <asm/io.h>
> > > +#include <asm/v7m.h>
> > > +
> > > +#define read_cpuid(reg)							\
> > > +	({								\
> > > +		WARN_ON_ONCE(1);					\
> > > +		0;							\
> > > +	})
> > 
> > We do have an MIDR in PMSAv7 (not to be confused with MPIDR), so why not read
> > that here?
> I don't know it and it's unrelated to this patch. But I will note it and
> check it. In the meantime I'm taking patches of course :-)

I don't think it is unrelated to this patch: I'm suggesting that you add an
MIDR read to read_cpuid, instead of the unconditional WARN_ON_ONCE which
you're adding here.

Then you can remove your v7m-specific read_cpuid_id implementation, because
read_cpuid(CPUID_ID) will do the right thing.

...or am I missing something?

Will
