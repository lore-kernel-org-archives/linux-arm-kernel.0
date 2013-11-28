From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Nov 2013 17:13:38 +0000
Subject: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
In-Reply-To: <20131126130553.GF25130@opensource.wolfsonmicro.com>
References: <527CB3A1.7050808@koalo.de> <527D1870.8080302@wwwdotorg.org>
 <20131126130553.GF25130@opensource.wolfsonmicro.com>
Message-ID: <20131128171338.GM27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 01:05:53PM +0000, Charles Keepax wrote:
> On Fri, Nov 08, 2013 at 09:59:28AM -0700, Stephen Warren wrote:

> > That all said, I wonder if the I2C core shouldn't do something like the
> > following inside i2c_add_adapter():
> > 
> > if (!adap->dev.of_node && adap->dev.parent)
> > 	adap->dev.of_node = adap->dev.parent->of_node;

> Should this not also have an of_node_get to increment the ref
> count on the node?

Given that it's pointing to the device that registered the I2C adaptor
it should be able to assume that there's a reference already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/5170cc34/attachment.sig>
