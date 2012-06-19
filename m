From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Jun 2012 21:18:20 +0200
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
Message-ID: <20120619191820.GA28139@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

I think i know why your machine locks up.

Your board file defines goflexnet_partitions but then never uses
it. So you have no SPI nor NAND device in operation. Without one of
these two, there is nothing using the RUNIT clock, so it gets turned
off. There appears to be something else in the RUNIT, so turning the
clock off causes the next access to what ever that is, to lock the
machine.

Try applying this patch:

http://www.spinics.net/lists/arm-kernel/msg178389.html

	Andrew
