From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 17 May 2010 11:07:37 +1000
Subject: [PATCH] phy/marvell: Add special settings for D-Link DNS-323
	rev C1
In-Reply-To: <20100517005942.GB27301@pengutronix.de>
References: <1274056058.21352.697.camel@pasglop>
	<20100517005942.GB27301@pengutronix.de>
Message-ID: <1274058457.21352.711.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 02:59 +0200, Wolfram Sang wrote:
> There is a fixup()-callback to prevent boardcode in the drivers. See
> Documentation/networking/phy.txt, last chapter.

Ah nice ! I missed that bit. I'll add a fixup and see if it works.

The problem is that writing to this register seems to be part of a
specific initialization sequence, which is done one way in the linux
driver and differently in the vendor kernel. I don't know whether
I can just 'override' the value and I have no docs for that part.

But I'll definitely give it a go tonight.

Cheers,
Ben.
