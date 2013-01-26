From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 12:52:09 +0800
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <20130126044219.GA10580@opensource.wolfsonmicro.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
Message-ID: <20130126045206.GB10580@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 12:42:26PM +0800, Mark Brown wrote:
> On Fri, Jan 25, 2013 at 02:14:28PM +0000, Arnd Bergmann wrote:
> > Gcc warns about the case where regmap_read_debugfs tries

> Are you sure about that function name?

> > to walk an empty map->debugfs_off_cache list, which results
> > in uninitialized variable getting returned.

> > Setting this variable to 0 first avoids the warning and
> > the potentially undefined value.

> This probably won't apply against current code as there's already a
> better fix there, in general just picking a value to initialise masks
> errors.

Resending with corrected list address; to be clear please don't send
this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/27ae051d/attachment.sig>
