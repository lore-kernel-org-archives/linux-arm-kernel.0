From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Mar 2014 18:52:10 -0500
Subject: [RFC] possible removal of omap-serial
Message-ID: <20140320235210.GB26964@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I've been toying with the idea of removing
drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
ungly copy of 8250 driver.

The original concern was wrt suspend/resume but I think it'd be a far
better approach to implement runtime PM in 8250 and write a rather small
8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
OMAP-specific details out of the way.

The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
instead of ttyS\d so removing omap-serial.c would have a direct impact
in userland. I wonder if it's an acceptable "regression" considering
we'd be able to reuse 8250 gaining proper Flow Control support, proper
DMA support, years and years of bug-fixes, etc.

What do you guys say ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/277e2096/attachment.sig>
