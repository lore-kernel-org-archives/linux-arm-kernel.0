From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 12:50:44 +0000
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <201202231233.05622.arnd@arndb.de>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <4F462444.8060406@st.com> <20120223113801.GV22562@n2100.arm.linux.org.uk>
 <201202231233.05622.arnd@arndb.de>
Message-ID: <20120223125044.GW22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 12:33:04PM +0000, Arnd Bergmann wrote:
> 3. Add a new set of consistent accessors that are explicitly meant for
> non-PCI on-chip components and make sure we really get them right this
> time and can retire some of the other ones eventually. This means it
> needs to be completely arch independent, include relaxed and strict
> accesses, little-endian/cpu-endian/native-endian and a well-documented
> address space (or more than one).

That won't work.  What's behind PCI in one area is on-chip on another.
See that with various PXA peripherals appearing behind PCI devices on
x86.  That's also happening with AMBA peripherals as well.

We *really* need to get away from that "PCI is special and has its own
accessors" or "on chip is special and has its own accessors" madness.
That's already starting to bite as being wrong.
