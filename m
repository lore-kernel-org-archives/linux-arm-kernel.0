From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 16:58:52 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <53C28B74.6010401@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de> <20140712194903.GB6800@sirena.org.uk>
 <53C28B74.6010401@metafoo.de>
Message-ID: <20140714155852.GG6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 03:36:52PM +0200, Lars-Peter Clausen wrote:
> On 07/12/2014 09:49 PM, Mark Brown wrote:

> >OTOH that's a more invasive change that's harder to do mechanically -
> >I'm not sure it's sensible to insist on someone doing it for generic
> >cleanups (rather than actively working with the particular platform).

> I don't think it is more invasive than using platform data. I did the same
> recently for jz4740 qi-lb60[1] and the changes in the patch are fairly
> trivial. The non-descriptor API is deprecated, so this even if this patch is
> applied as is sooner or later somebody will mechanically convert it to the
> descriptor API.

> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=218e18a3728507ee82ed2eb10c789671a00e34bd

The translation into the GPIO_LOOKUP() macros isn't sufficiently direct,
with platform data it's just a case of putting the same data in a
different file but with this you need to figure out what the GPIO bank
is called which won't appear in the diff typically.  Someone will
doubtless want to finish up the gpiod_ transition at some point but it's
not yet at the point where it's worth blocking unrelated cleanups for
it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/188c61c2/attachment.sig>
