From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Jun 2010 14:13:19 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <alpine.LFD.2.00.1006080857390.30664@xanadu.home>
References: <4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080839240.30664@xanadu.home>
	<20100608125053.GD25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080857390.30664@xanadu.home>
Message-ID: <20100608131319.GF25370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 08, 2010 at 09:01:35AM -0400, Nicolas Pitre wrote:
> I wouldn't give up on that option just yet though.  I don't think he 
> fully understood your idea, and without an actual patch it might be hard 
> to understand as well, especially for people who are not used to deal 
> with the target varieties we have on ARM.  Linus is also known to change 
> his mind when presented with evidences.

The two ideas are very close to each other - and can be generated
together.

If we create something like Linus' preferred solution, we can then do
in the main arch/arm/Kconfig:

config STD_CONFIG
	bool "blah"

if STD_CONFIG

if MACH_WHATEVER
include arch/arm/config/Kconfig.whatever
endif

if MACH_BLAH
include arch/arm/config/Kconfig.blah
endif

endif

which should work as per my idea.
