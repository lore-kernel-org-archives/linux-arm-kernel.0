From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 26 Feb 2010 07:52:58 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <Pine.LNX.4.44L0.1002241641370.1253-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1002241641370.1253-100000@iolanthe.rowland.org>
Message-ID: <1267131178.23523.1729.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-24 at 16:50 -0500, Alan Stern wrote:
> The main issue here is that the same host controller will use PIO
> sometimes and DMA sometimes, depending on the details of the
> transfer.  
> The USB core didn't expect this and consequently we violated the rules
> for DMA mapping.  The question is: If the core is fixed so that the
> rules aren't violated, will everything work correctly? 

As long as the only issue is that one (ie, doing PIO while dma-map'ed),
then yes, I'd say things should work. If not, then there is -another-
problem to be fixed :-)

Cheers,
Ben.
