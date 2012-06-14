From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 14 Jun 2012 21:35:24 +1000
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <20120614091434.GB14419@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
 <1339623217.9220.119.camel@pasglop> <20120614091434.GB14419@pengutronix.de>
Message-ID: <1339673724.9220.164.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-14 at 11:14 +0200, Wolfram Sang wrote:
> On Thu, Jun 14, 2012 at 07:33:37AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> > > Currently, every driver has to do it on its own, but it should be done
> > > in the core, like we already do with board_info structs.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > ---
> > > 
> > > Based on v3.5-rc2. Only build tested, I don't have a OF based device
> > > around at the moment.
> > 
> > Won't that conflict with i2c-powermac doing it its own way ?
> 
> Yup :(
> 
> I assume there is no chance that the powermac devicetree can be
> pre-processed to be compatible with of_i2c_register_devices?

That would be nasty and need a lot of testing on all sort of machines I
don't have direct access to.

Maybe we can set a flag somewhere to indicate to the core not to run the
default probing on that controller ?

Cheers,
Ben.
