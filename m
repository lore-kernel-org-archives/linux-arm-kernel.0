From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 11 Jan 2011 18:30:18 +0800
Subject: Locking in the clk API
In-Reply-To: <20110111101314.GA774@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111101314.GA774@linux-sh.org>
Message-ID: <201101111830.18597.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> No, the sleeping clock case is and always will be a corner case, and I
> have no interest in pretending otherwise. On SH we have hundreds of
> clocks that are all usable in the atomic context and perhaps less than a
> dozen that aren't (and even in those cases much of the PLL negotiation is
> handled in hardware so there's never any visibility for the lock-down
> from the software side, other architectures also have similar behaviour).

I'm not too worried about the corner-cases on the *implementation* side, more 
the corner-cases on the API side: are we seeing more users of the API that 
require an atomic clock, or more that don't care?

Cheers,


Jeremy
