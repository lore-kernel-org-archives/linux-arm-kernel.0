From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 13:29:25 +0000
Subject: [PATCH v2 2/7] MFD: twl6040: Convert to i2c driver, and separate
 it from twl core
In-Reply-To: <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120207132925.GN3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:01:13PM +0200, Peter Ujfalusi wrote:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.

Looking good

Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>

and it looks like you'll save a bunch more code if you're able to
convert over to using a regmap cache.  Note that as a first pass you
just need to define which registers are volatile and enable a cache type
- if defaults are omitted then the values will be read back from the
device to start off with.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/819ed61f/attachment.sig>
