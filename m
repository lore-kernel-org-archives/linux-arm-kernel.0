From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Apr 2014 22:00:01 +0100
Subject: [PATCH] regmap: i2c: fallback to SMBus if the adapter does not
 support standard I2C
In-Reply-To: <534EBADE.1000608@free-electrons.com>
References: <20140415223849.GJ12304@sirena.org.uk>
 <1397636170-664-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140416170638.GT12304@sirena.org.uk>
 <534EBADE.1000608@free-electrons.com>
Message-ID: <20140416210001.GA12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 07:16:14PM +0200, Boris BREZILLON wrote:

> Actually I do not modify the passed config struct, I copy the config
> values into a local instance and then modify this local instance
> appropriately.
> But I agree that having a proper way to overload config parameters would
> be better.
> Any suggestion on how this should be done ?

I think just adding them as operations in the bus struct should work,
though I only had a fairly quick scan through so I might have missed a
case where it's more than just the init that needs updating to take
account of there being a bus with these ops.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/d3bbe62f/attachment.sig>
