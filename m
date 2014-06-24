From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 15:47:51 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624133157.GC6993@lunn.ch>
References: <7416978.W29blLsymn@wuerfel> <20140624133157.GC6993@lunn.ch>
Message-ID: <9076405.UGmihAddxu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 15:31:57 Andrew Lunn wrote:
> On Tue, Jun 24, 2014 at 03:17:06PM +0200, Arnd Bergmann wrote:
> > Since 3.16, we have the ability to build a multiplatform kernel
> > that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> > 
> > I accidentally stumbled over a bug in the VFP code that looks
> > like it will break at least ARM9 VFP support if CPU_FEROCEON
> > is also enabled, introduced by this (old) commit:
> 
> Hi Arnd
> 
> CPU_FEROCEAN is currently selected by Orion5x, Kirkwood and mv78xx0.
> These are all ARMv5 machines. As far as i understand, we cannot
> combine ARMv5 with ARMv6 and above. So is this really an issue? Should
> we put in something defensive to prevent it being selected on anything
> other than ARMv5?

I don't think we have to worry about ARMv6 and above, we just need
to solve it for ARM926E(J), which is the same architecture level
as Feroceon and can now be built into the same kernel in reasonable
configurations.

	Arnd
