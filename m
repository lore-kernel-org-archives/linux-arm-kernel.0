From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Nov 2016 22:37:41 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105212748.vtdprlxxismy5xmk@perseus.defre.kleine-koenig.org>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <20161105212326.GC1216@lunn.ch>
 <20161105212748.vtdprlxxismy5xmk@perseus.defre.kleine-koenig.org>
Message-ID: <20161105213741.GD1216@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2016 at 10:27:49PM +0100, Uwe Kleine-K?nig wrote:
> Hello Andrew,
> 
> On Sat, Nov 05, 2016 at 10:23:26PM +0100, Andrew Lunn wrote:
> > > Still missing is support for the switch.
> > 
> > Is it a Marvell Switch? armada-370-rd.dts would be a good start for
> > the old binding? vf610-zii-dev-rev-b.dts uses the new binding.
> 
> Yeah, a 88E6176. I already try to understand vf610-zii-dev-rev-b.dts. Do
> you know if this driver works for the 88E6176?

Yes it does. 

The vf610-zii-dev-rev-b is a bit complex because it has three
switches, and an mdio mux. You should be able to transplant the
switch0: switch0 at 0 part into the mdio node.

	 Andrew
