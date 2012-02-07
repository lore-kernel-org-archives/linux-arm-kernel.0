From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 13:43:44 +0000
Subject: [PATCH v2 2/7] MFD: twl6040: Convert to i2c driver, and separate
 it from twl core
In-Reply-To: <4F31298C.5090008@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
 <20120207132925.GN3332@opensource.wolfsonmicro.com>
 <4F31298C.5090008@ti.com>
Message-ID: <20120207134344.GP3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:39:24PM +0200, Peter Ujfalusi wrote:

> In the codec driver I have one 'shadow' register which does not exist on
> the HW. I'm going to need to have access to that shadow register's bits
> in the future transparently.

Alternatively just rewrite the code for that to use a variable in the
driver private data.

> I was wondering if we could add support to regmap for such SW only
> registers. This would only make sens if the cache is enabled. We could
> have a callback let's say shadow_reg() in remap_config struct. If it is
> a shadow reg we never reach out for the HW and operate only on the cache.
> Is this something we can add to regmap?

That just sounds far too icky - I'm really not happy that people have
been doing that in ASoC TBH, it just makes everything more tricky than
it should be.  It save a little bit of effort with the control but just
pushes that complexity elsewhere where you're not expecting it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/dba445cc/attachment.sig>
