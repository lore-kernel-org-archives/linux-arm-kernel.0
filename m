From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 12:45:38 +0000
Subject: [RFC 06/18] regmap: Formalise use of non-bus context
In-Reply-To: <1387815830-8794-7-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-7-git-send-email-pawel.moll@arm.com>
Message-ID: <20131224124538.GZ30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 04:23:38PM +0000, Pawel Moll wrote:

I'd note that I wasn't CCed on most of this series so I'm not entirely
sure what it's trying to do.

> Bus-less maps (ones with reg_read and reg_write functions
> defined in regmap_config) were given the context passed
> in regmap_init(), but it was still called "bus_context".
> 
> This patch formalises this aspect by renaming it to simple
> "context" and adds the missing link, free_context function
> in regmap_config, which allows bus-less maps to use the
> context in classic way.

This should be two patches, one patch to do the rename and one to add
the operation.  The obvious question here is why is this callback useful
- what is being allocated in a regmap specific context that needs to be
lifetime managed separately to the thing doing the creation?  I can't
see any obvious reason why this would ever get used.
