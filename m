From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Mar 2016 12:46:41 +0100
Subject: [PATCH] dma: sun4i: expose block size and wait cycle
 configuration to DMA users
In-Reply-To: <20160311111825.GC11154@localhost>
References: <20160307145429.GG11154@localhost>
 <20160307160857.577bb04d@bbrezillon>
 <20160307203024.GD8418@lukather> <20160308025547.GI11154@localhost>
 <20160309120627.67612b1d@bbrezillon>
 <20160311062607.GP11154@localhost>
 <20160311104552.23e06a16@bbrezillon>
 <20160311100902.GY11154@localhost> <20160311105549.GZ8418@lukather>
 <20160311111825.GC11154@localhost>
Message-ID: <20160314114641.GC30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 04:48:26PM +0530, Vinod Koul wrote:
> > > But this nees to be property for clients and not driver. Client can then
> > > program these
> > 
> > Yes, totally. The question here is how the clients give that
> > information to the driver.
> 
> For this part am not worried. If we can generalize this then we add to
> dma_slave_config. Otherwise an exported symbol from driver should be fine.

It's actually what we would like to avoid.

We have two potential provider driver that would need such an
interface, and we have customer drivers that would be able to use any
of these two, depending on which SoCs we're talking about.

Maintaining some logic in each and every driver in that case to know
which one of this symbol is to be called seems counterproductive and
painful.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/040a5e45/attachment.sig>
