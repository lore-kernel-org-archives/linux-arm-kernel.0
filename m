From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Oct 2015 16:42:31 +0100
Subject: [PATCH] regulator: core: avoid unused variable warning
In-Reply-To: <5130320.kXvB35QoYU@wuerfel>
References: <5130320.kXvB35QoYU@wuerfel>
Message-ID: <20151012154231.GE4238@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 02:36:47PM +0200, Arnd Bergmann wrote:

> The second argument of the mutex_lock_nested() helper is only
> evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
> get this build warning for the new regulator_lock_supply
> function:

Shouldn't we have an annotation or something for this in
mutex_lock_nested()?  It seems like something that might come up
elsewhere and it's a bit of a surprise to have one of the arguments
there not be evaluated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/7f04d4b2/attachment.sig>
