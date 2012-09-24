From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Sep 2012 07:23:01 +0200
Subject: [GIT PULL V5 0/7] ARM: kirkwood/dove/mvebu changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120924052301.GE14266@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Jason.

I tested arm-soc/late/kirkwood on an orion5x board. There is an
unrelated problem, which i should of really seen earlier....

ERROR: 256 KiB atomic DMA coherent pool is too small!
Please increase it with coherent_pool= kernel parameter!

We had the same problem with kirkwood. I will submit a patch against
3.6-rc7. Is there still time for that? Otherwise it would be good to
have in 3.7 and cc: stable so 3.6.1 gets the fix.

When i increase the coherent pool size on the command line, it boots
O.K. I don't have any PCI devices on this board, but the two root
controllers are listed by lspci.

Tested-by: Andrew Lunn <andrew@lunn.ch>

	   Andrew
