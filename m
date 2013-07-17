From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 17:53:00 +0100
Subject: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
In-Reply-To: <20130717142628.GN7080@book.gsilab.sittig.org>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-2-git-send-email-gsi@denx.de>
 <20130715201734.GF11538@sirena.org.uk>
 <20130717112229.GK7080@book.gsilab.sittig.org>
 <20130717120758.GR22506@sirena.org.uk>
 <20130717142628.GN7080@book.gsilab.sittig.org>
Message-ID: <20130717165300.GU22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 04:26:28PM +0200, Gerhard Sittig wrote:
> On Wed, Jul 17, 2013 at 13:07 +0100, Mark Brown wrote:

> > This is a pretty long e-mail.  It'd probably have taken less time to
> > fix the issues than to reply to the e-mail...  but anyway.

> Not quite.  Please consider that careful submission is as
> expensive as thorough review is, and that a lot of work is done
> before v1 gets submitted, which you may not always notice from
> looking at a concentrated series that may no longer suggest how
> much it took to get there (especially when prepared carefully).

This is rather undermined the more time and effort gets spent pushing
back against doing trival fixes, of course...  besides, the issues here
are all really simple to fix and test.  It's not a major or risky
rewrite of the driver or anything like that - most of this can be tested
by just probing the driver.

> As mentioned before I did not question the need to fix issues as
> they get identified.  I just asked whether reworking the serial

OK, so send patches then.

> The initial COMMON_CLK implementation in part 09/24 registers
> clkdev items for compatibility during migration.  The string
> isn't greppable since it's constructed by the preprocessor in the
> MCLK data setup, see the MCLK_SETUP_DATA_PSC() macro.

Ugh, right - it didn't show up in searches due to being hidden by the
macro.

> Now let me see how I can improve the SPI driver with regard to
> overall clock handling and beyond mere operation by coincidence
> in the absence of errors.  But please understand that I don't
> want to stall the common clock support for a whole platform just
> because some of the drivers it needs to touch to keep them
> operational have other issues that weren't addressed yet, while
> these issues aren't introduced with the series but preceed it.

Again, you're not being asked to implement substantial new functionality
here.  From my point of view I can't test this at all so I'm looking at
code that's obviously not good for the standard clock API and wondering
if it even works or how robust it's going to be going forward as the
common clock code changes which makes me relucatant to say it'll be OK.

The fact that you're switching over to use generic code is itself a
reason to make sure that the API usage is sane, dodgy API usage against
open coded clock implementations is less risky than against the common
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/df54aed2/attachment.sig>
