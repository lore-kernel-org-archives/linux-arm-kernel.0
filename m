From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Jan 2011 21:20:17 +0000
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK
	tospeed-up boot
In-Reply-To: <bccc6a7edf66bedd311bc869bfa89ae8@mail.gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
	<43c027bd53818ab19bdc1c823aa21ea4@mail.gmail.com>
	<4D38641E.2000301@gmail.com>
	<c1a2c539e2677e9a56d2d3aaaaf34851@mail.gmail.com>
	<4D399F74.9050302@gmail.com>
	<20110121171555.GB30823@n2100.arm.linux.org.uk>
	<bccc6a7edf66bedd311bc869bfa89ae8@mail.gmail.com>
Message-ID: <20110122212017.GA17725@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 22, 2011 at 01:14:21PM +0530, Santosh Shilimkar wrote:
> Surely whichever way we should remove the recalibration otherwise
> every time secondary cpus spend ~ 200 ms there.
> 
> Russell,
> How do you like to address this?

Well, the last piece of the puzzle which needs consideration is that
omitting the calibration means that it produces user-visible
/proc/cpuinfo changes.  I can't say what effect that has.  So, I
think we need to do something about that to ensure that userspace
won't be impacted should they be using the information in there.

Maybe we need to initialize the secondary CPU bogomips values
accordingly?  Maybe zero is acceptable to mark that the calculation
hasn't been done?  Dunno.
