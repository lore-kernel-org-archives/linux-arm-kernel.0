From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Nov 2015 12:24:00 +0000
Subject: [PATCH, once again] regulator: core: avoid unused variable warning
In-Reply-To: <15541673.tdJ35xzzlG@wuerfel>
References: <4219157.sstthfjICN@wuerfel> <20151120114127.GS31303@sirena.org.uk>
 <15541673.tdJ35xzzlG@wuerfel>
Message-ID: <20151120122400.GA1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 01:12:00PM +0100, Arnd Bergmann wrote:
> On Friday 20 November 2015 11:41:27 Mark Brown wrote:

> > Can we please at least have a comment explaining that this is working
> > around lockdep limitations?

> Not sure which limitation you are referring to. Maybe you could just
> modify the changelog text as you like when applying the patch?

> I tried to capture the fact that mutex_lock_nested() intentionally
> doesn't evaluate its second argument when CONFIG_DEBUG_LOCK_ALLOC
> is not set, but that appears to be less of a limitation than a
> choice of the interface.

That's the limitation (or intereface choice or whatever) that I'm
talking about - the code looks like a function call so not evaulating
the second argument is surprising.  I'm looking for something in the
code rather than the changelog so it doesn't get cleaned up later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/5b9d2824/attachment.sig>
