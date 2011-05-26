From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2011 23:25:12 +0100
Subject: [PATCH] ARM: Xilinx: Adding zynq platform support
In-Reply-To: <BANLkTin40KK-SahXEP3c1EH1+fWgB54aFw@mail.gmail.com>
References: <BANLkTiknh4nCviohecbcJEiWnSW-JdMxDw@mail.gmail.com>
	<alpine.LFD.2.00.1105241435550.3207@xanadu.home>
	<BANLkTi=hCpCbNzi1ZiKmGnbhmCG2Ce=EkA@mail.gmail.com>
	<201105261559.41993.arnd@arndb.de>
	<20110526150655.GA26661@ponder.secretlab.ca>
	<20110526220120.GN24876@n2100.arm.linux.org.uk>
	<BANLkTi=mL=J4UeKgFEa9y3C==8f9eKkboA@mail.gmail.com>
	<BANLkTin40KK-SahXEP3c1EH1+fWgB54aFw@mail.gmail.com>
Message-ID: <20110526222512.GO24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 04:16:10PM -0600, Grant Likely wrote:
> Will you pick up the zynq patch also?

It's about 1000 new lines, and I'm not sure Linus will take that
level of addition - certainly not without explanation.

Also, if we adhere to the policy that we don't introduce new code
which should be using the consolidated code which we've already
introduced, this would need to be updated to use the mmio
clocksource stuff at the very least.

I'm also not convinced that this platform would have the ICST PLL
chips on it, so why it needs to select ICST I'm not sure (as well
as having the PLL parameters in its struct clk.)
