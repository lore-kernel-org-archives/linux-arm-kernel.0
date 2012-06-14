From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 14 Jun 2012 16:17:06 +0200
Subject: Converting kirkwood-goflexnet to DTS
Message-ID: <20120614141706.GA6676@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

Welcome to the fun...

# CONFIG_SERIAL_OF_PLATFORM is not set

You need this one, if you want the serial ports to work...  Also,
don't be surprised when they do work, even though IRQ=0!

It is a good idea to build the kernel with earlyprintk support and to
pass it as a kernel parameter.

Also, -rc2 is FUBAR on all Orion platforms, unless you have:

http://comments.gmane.org/gmane.linux.ports.arm.kernel/170442

	Andrew
