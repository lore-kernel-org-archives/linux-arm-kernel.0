From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Apr 2010 09:57:17 +0100
Subject: [RFC] IDLE/DEEP IDLE scheduler modification for power savings
In-Reply-To: <000001cada24$01a5ee90$04f1cbb0$%majewski@samsung.com>
References: <000001cada24$01a5ee90$04f1cbb0$%majewski@samsung.com>
Message-ID: <20100413085716.GB22320@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 11:39:05AM +0200, Lukasz Majewski wrote:

> Some SoCs allow for entering IDLE mode when they know that the system will
> be
> "inactive" for some time (to be more precise it will execute the idle task -
> which prepares system to enter IDLE state). In that mode CPU core is not
> active
> (CPU core is clock gated) and may be woken up by several interrupts. IDLE
> mode entering is already implemented in the kernel and works smoothly.

Have you looked at the cpuidle infrastructure in the kernel?  It's
mostly used on desktop systems at the minute but IIRC there was some
investigation into use in embedded environments.  There's also the work
that's been done on OMAP and SH CPUs in this area.
