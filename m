From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Sep 2010 12:20:28 -0500
Subject: [PATCH 9/9] ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)
In-Reply-To: <000001cb4ac0$e5b2fd00$b118f700$@lindholm@arm.com>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135855.21304.5457.stgit@e102109-lin.cambridge.arm.com>
	<20100901040801.GA10431@lixom.net>
	<000001cb4ac0$e5b2fd00$b118f700$@lindholm@arm.com>
Message-ID: <20100902172028.GA6153@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 06:04:24PM +0100, Leif Lindholm wrote:
> > From: Olof Johansson [mailto:olof at lixom.net]
> > >
> > > This patch adds the alternative solution to emulate the SWP and SWPB
> > > instructions using LDREX/STREX sequences, and log statistics to
> > > /proc/cpu/swp_emulation. To correctly deal with copy-on-write, it
> > also
> > 
> > Sounds like debugfs would be a better place to export this through?
> > That's what PPC does.
> 
> It made sense to me to place it with /proc/cpu/alignment.
> Moving both of these into debugfs might well make sense in the future,
> but I think that should be a separate patch.

Yep, works for me.


-Olof
