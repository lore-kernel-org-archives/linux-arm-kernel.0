From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 16:12:56 +0100
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <4E42965A.9010500@calxeda.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<201108101609.56995.arnd@arndb.de> <4E42965A.9010500@calxeda.com>
Message-ID: <20110810151256.GN10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 03:31:54PM +0100, Rob Herring wrote:
> Here's all the interrupts on the PL310:
> 
> DECERRINTR Decode error received on master ports from L3
> SLVERRINTR Slave error received on master ports from L3
> ERRRDINTR Error on L2 data RAM read
> ERRRTINTR Error on L2 tag RAM read
> ERRWDINTR Error on L2 data RAM write
> ERRWTINTR Error on L2 tag RAM write
> PARRDINTR Parity error on L2 data RAM read
> PARRTINTR Parity error on L2 tag RAM read
> ECNTRINTR Event Counter Overflow/Increment
> L2CCINTR L2CC Combined Interrupt Output
> 
> It's likely that you would want to split these to different drivers.
> EDAC for parity/bus errors and hw-events for event counters, for example.

I completely agree with you here. In reality, I expect we'll be lucky if
even the combined interrupt is wired up so maybe the individual property
names should only be added on an as-needed basis? For the time being we can
happily get by with something like combined-interrupt = <...>.

Or would you rather specify everything up front?

Will
