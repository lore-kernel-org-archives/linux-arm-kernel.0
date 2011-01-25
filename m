From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Jan 2011 10:26:52 +0000
Subject: questions about arm trustzone
In-Reply-To: <AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
	<8yad3nlh18e.fsf@huya.qualcomm.com>
	<AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
Message-ID: <20110125102652.GB11507@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 05:19:16PM +0800, sen wang wrote:
> It seems linux run in the normal world, and the "scm.c" ?is the path
> to the monitor mode.
> where can I find the example code for monitor and secure world?

OMAP also uses smc: arch/arm/mach-omap2/omap44xx-smc.S

There's no interface defined for smc because it's highly vendor and
implementation specific.  It's just like a SWI (or svc) where it
causes entry via a vector into a priviledged mode, which can be
thought of being similar to a branch to a vector with a mode switch.
