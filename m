From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 11:14:56 +0100
Subject: [PATCH V2 0/6] arm_smp_twd: mpcore_wdt: Fix MPCORE watchdog setup
In-Reply-To: <4E14337F.1050101@arm.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-1-git-send-email-vkuzmichev@mvista.com>
	<4E14337F.1050101@arm.com>
Message-ID: <20110706101456.GN8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 11:05:51AM +0100, Marc Zyngier wrote:
> Hi Vitaly,
> 
> On 05/07/11 20:00, Vitaly Kuzmichev wrote:
> > The series of patches fixes various bugs in ARM MPCORE watchdog setup.
> > They also introduce some changes in common ARM_SMP_TWD timer setup code.
> > The PATCH 2/6 adds an exported function to obtain twd timer rate in
> > mpcore_wdt. However, this solution might be unacceptable, and the
> > better is to copy calibration loop and clk_get_rate calling to mpcore_wdt.
> 
> My take on this is that the calibration loop should simply be killed
> once Colin's patch using the "smp_twd" clock is merged and relevant
> platforms updated. Once this is done, the watchdog driver should use the
> clock directly, without exporting a symbol.

Do we know why the calibration was initially introduced?  FWIR, it came
from the SMP group in ARM, so I guess they had a reason for it rather
than copying x86.
