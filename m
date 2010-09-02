From: leif.lindholm@arm.com (Leif Lindholm)
Date: Thu, 2 Sep 2010 18:04:24 +0100
Subject: [PATCH 9/9] ARM: Add SWP/SWPB emulation for ARMv7 processors	(v5)
In-Reply-To: <20100901040801.GA10431@lixom.net>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135855.21304.5457.stgit@e102109-lin.cambridge.arm.com>
	<20100901040801.GA10431@lixom.net>
Message-ID: <000001cb4ac0$e5b2fd00$b118f700$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Olof Johansson [mailto:olof at lixom.net]
> >
> > This patch adds the alternative solution to emulate the SWP and SWPB
> > instructions using LDREX/STREX sequences, and log statistics to
> > /proc/cpu/swp_emulation. To correctly deal with copy-on-write, it
> also
> 
> Sounds like debugfs would be a better place to export this through?
> That's what PPC does.

It made sense to me to place it with /proc/cpu/alignment.
Moving both of these into debugfs might well make sense in the future,
but I think that should be a separate patch.

/
    Leif
