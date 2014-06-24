From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Jun 2014 15:31:57 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <7416978.W29blLsymn@wuerfel>
References: <7416978.W29blLsymn@wuerfel>
Message-ID: <20140624133157.GC6993@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:17:06PM +0200, Arnd Bergmann wrote:
> Since 3.16, we have the ability to build a multiplatform kernel
> that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> 
> I accidentally stumbled over a bug in the VFP code that looks
> like it will break at least ARM9 VFP support if CPU_FEROCEON
> is also enabled, introduced by this (old) commit:

Hi Arnd

CPU_FEROCEAN is currently selected by Orion5x, Kirkwood and mv78xx0.
These are all ARMv5 machines. As far as i understand, we cannot
combine ARMv5 with ARMv6 and above. So is this really an issue? Should
we put in something defensive to prevent it being selected on anything
other than ARMv5?

	 Andrew
