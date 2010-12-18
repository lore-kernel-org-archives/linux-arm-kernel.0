From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 20:04:43 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
References: <20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
	<AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
	<20101218120154.GA4803@n2100.arm.linux.org.uk>
	<AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
Message-ID: <20101218200443.GM9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 06:10:49AM -0600, Andrei Warkentin wrote:
> Definitely. This would be exactly the right place to place any holding
> logic...

FYI, I've managed to get some timing figures out of my Versatile
Express platform.  It takes about 100us for a CPU to come online via
hotplug, and a further 222ms to run the calibration before marking the
CPU online.

That leaves a margin of about 750ms before the timeout in the generic code
fires.

CPU requesting hotplug, times in ns:
SMP: Start: 0
SMP: Booting: 750
SMP: Cross call: 3500
SMP: Pen released: 41167
SMP: Unlock: 42417
SMP: Boot returned: 43250

CPU being brought online, referenced to "SMP: Start" above, times in ns.
SMP: Sec: restart: 3834
SMP: Sec: up: 5334
SMP: Sec: enter: 30667
SMP: Sec: pen write: 38917
SMP: Sec: pen done: 41417
SMP: Sec: exit: 42750
SMP: Sec: calibrate: 91834
SMP: Sec: online: 222054375
