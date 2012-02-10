From: khilman@ti.com (Kevin Hilman)
Date: Thu, 09 Feb 2012 18:33:46 -0800
Subject: [PATCH] ARM: OMAP2xxx: PM: fix OMAP2xxx-specific UART idle bug in
 v3.3
In-Reply-To: <alpine.DEB.2.00.1202091822170.5059@utopia.booyaka.com> (Paul
 Walmsley's message of "Thu, 9 Feb 2012 18:24:03 -0700 (MST)")
References: <alpine.DEB.2.00.1202091822170.5059@utopia.booyaka.com>
Message-ID: <8762ffzab9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> [ This patch is targeted for v3.3-rc ]
>
> On OMAP2420-based systems, the PM code ignores the state of the UART
> functional clocks when determining what idle state to enter.  This
> breaks the serial port now that the UART driver's clock behavior can
> be controlled via the PM autosuspend timeout.
>
> To fix, remove the special-case idle handling for the UARTs in the
> OMAP2420/2430 PM idle code added by commit
> 4af4016c53f52b26461b8030211f8427a58fa5ed ("OMAP3: PM: UART: disable
> clocks when idle and off-mode support").
>
> Tested on Nokia N800.  This patch is a collaboration between Tony
> Lindgren <tony@atomide.com> and Paul Walmsley <paul@pwsan.com>.
>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@ti.com>
