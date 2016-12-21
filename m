From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Dec 2016 17:50:13 +0100
Subject: [PATCH] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20161221151814.GJ30952@lunn.ch>
References: <20161221102047.28036-1-uwe@kleine-koenig.org>
 <20161221151814.GJ30952@lunn.ch>
Message-ID: <20161221165012.cyvotxbjtqqkna33@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Wed, Dec 21, 2016 at 04:18:14PM +0100, Andrew Lunn wrote:
> On Wed, Dec 21, 2016 at 11:20:47AM +0100, Uwe Kleine-K?nig wrote:
> > when the MAC is operated in rgmii mode and the switch in rgmii-id
> > communication between them works fine. The other way round it doesn't work.
> > The fixed-link nodes in the cpu port description is necessary to let the
> > mv88e6xxx driver use the phy-mode description. Is this a bug?
> 
> It is somewhat deliberate. Normally, there is no phy at all for a cpu
> port or a dsa port. If there is no phy, it makes no sense to set the
> phy-mode. With fixed-link, there is a phy connected to the MAC, in
> terms of how the network stack sees the devices. It is a somewhat
> special phy, in fact its bandwidth is fixed, but it does support
> phy-handle, and a few other phy properties and callbacks.

Here the switch is the phy, and in this case it is necessary to
correctly configure it's physical properties. fixed-link is conceptual
wrong here because (IIUC) this is for MACs only. So (maybe also for DSA
v3 or a general phy cleanup) a standard binding to specify this which
doesn't formalise the switch (or general: phy) as MAC.

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161221/2dc91dc6/attachment.sig>
