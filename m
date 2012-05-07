From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 16:17:44 +0100
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <201205071509.55166.arnd@arndb.de>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205071314.51886.arnd@arndb.de>
 <20120507140634.GD17002@opensource.wolfsonmicro.com>
 <201205071509.55166.arnd@arndb.de>
Message-ID: <20120507151744.GI17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 03:09:54PM +0000, Arnd Bergmann wrote:
> On Monday 07 May 2012, Mark Brown wrote:

> > Given what I'm saying about platform devices above perhaps we should be
> > factoring some of the platform device stuff up to struct device level.
> > Another option would be to work on separating the management of the
> > number spaces and the interfaces for getting the numbers back out to
> > make it easier to add more number spaces.

> Isn't that what devres is for? We should be able to just attach arbitrary
> data to a device with this, e.g. a struct regmap to use for doing I/O
> that a driver can use. Maybe we should add some wrappers around that
> to make it more obvious to use.

Not as far as I understand it, it's more about making error handling and
unregistration code less error prone by automating the freeing of
things when a device goes away or probe() fails.  The managed versions
wrap the unmanaged allocators but don't generally otherwise change the
interface except by adding a struct device.  Unless I'm missing
something, of course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/6dcfa6bf/attachment.sig>
