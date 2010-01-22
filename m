From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 22 Jan 2010 13:56:26 +0100
Subject: [spi-devel-general] PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
In-Reply-To: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/20 Kevin Wells <kevin.wells@nxp.com>:

> Added logic to cap TX FIFO fill size based on current free RX
> FIFO entries instead of TX status flags. This is to prevent
> an issue with RX FIFO overflows

Excellent patch and works like a charm on the U300. My loopback code
would generate
spurious overfill errors before and now it *never* fails so you hit
exactly the right spot.
I remember being intrigued by this when I worked on the driver and now
it is finally
nailed.

As some sort of maintainer of this file I have signed it off and put
it into Russells
patch tracker for inclusion, OK? See;
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5893/1

Linus Walleij
