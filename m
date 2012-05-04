From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 May 2012 19:58:51 +0100
Subject: Handling of modular boards
Message-ID: <20120504185850.GO14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quite a few reference platforms (including Wolfson ones, which is why
I'm particularly interested) use replaceable modules to allow
configuration changes.  Since we can often identify the configuration at
runtime we should ideally do that but currently there's no infrastructure 
to help with that, generally this seems to be done in arch code for the
machine but this doesn't scale when even the CPU might change and isn't
terribly device tree compatible either.

For reference the code for current Wolfson plugin modules is in
arch/arm/mach-s3c64xx/mach-crag6410-module.c.

The most obvious current fit here is the MFD subsystem but it feels like
we need some slightly different infastructure to what MFD currently
provides.  MFD is really set up to handle platform devices with a core
and linear ranges of resources fanning out from that core since they're
really oriented around chips.  In contrast these boards are more about
remapping random collections of potentially unrelated resources and
instantiating devices on all sorts of buses and share more with board
files.

I'm just starting to put some stuff together for this so I was wondering
if anyone had been thinking about this and had any bright ideas for how
to handle it, and also if people think that MFD is a good fit for this
or if we should split the silicon MFDs from these PCBs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/63fe30a3/attachment.sig>
