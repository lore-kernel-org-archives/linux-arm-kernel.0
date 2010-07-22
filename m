From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 22 Jul 2010 16:01:05 +0200
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <20100722102140.GD31293@n2100.arm.linux.org.uk>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
	<20100721085024.GD6009@n2100.arm.linux.org.uk>
	<1279703355.27276.100.camel@pororo.lan>
	<20100722094643.GB31293@n2100.arm.linux.org.uk>
	<1279793204.27276.129.camel@pororo.lan>
	<20100722102140.GD31293@n2100.arm.linux.org.uk>
Message-ID: <1279807265.27276.131.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> n8x0 is the only one which looks suspicious, but I assume fails for a
> reason unrelated to this change.  n8x0 is an OMAP2 platform which does
> have a debug-macros.S file.

Right you are. Looking back at the log, this is due to:

drivers/usb/musb/tusb6010.c:34: error: expected identifier or '(' before
'do'
drivers/usb/musb/tusb6010.c:34: error: expected identifier or '(' before
'while'
drivers/usb/musb/tusb6010.c:39: error: expected identifier or '(' before
'do'
drivers/usb/musb/tusb6010.c:39: error: expected identifier or '(' before
'while'

so yes, unrelated to the debug stuff.

Cheers,


Jeremy
