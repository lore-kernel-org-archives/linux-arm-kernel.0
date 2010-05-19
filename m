From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 May 2010 13:08:43 +0100
Subject: Boot interface for device trees on ARM
In-Reply-To: <AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<AANLkTilJl9_NHiT1LITG7UbA9S7OYsnGMcDAsFEEx5Ob@mail.gmail.com>
Message-ID: <20100519120843.GB24520@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 05:57:55AM -0600, Grant Likely wrote:
> side question: Do recent ARM SoCs provide any facility to reliably
> detected the silicon at run time?  ie. like the processor (unique to
> core) and system (unique to SoC) id registers on PowerPC.

No.

Every SoC is effectively unique in all aspects.  There is no common
physical memory layout, no common interrupt controller, no common
timer, etc.  The base addresses for everything is also SoC specific,
so it's a catch-22 situation - you need to know what the SoC is to
be able to find out where various registers and memory is located.
