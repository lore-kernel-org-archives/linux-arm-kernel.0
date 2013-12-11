From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 16:02:25 +0000
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <52A88805.1080704@redhat.com>
References: <52A88805.1080704@redhat.com>
Message-ID: <20131211160225.GB11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 04:43:01PM +0100, Hans de Goede wrote:

> While looking into making regulator_get_optional not print
> an error when no regulator is found, I've noticed that
> for dt enabled boards, has_full_constraints is not set
> until regulator_init_complete() runs, which is a
> late_initcall.

> This means that it gets set after it has already been checked
> from calls like regulator_get which are likely done by init
> functions running earlier.

> This seems wrong ...

Please look at the current code, that's not how this works any more.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/55f674c2/attachment.sig>
