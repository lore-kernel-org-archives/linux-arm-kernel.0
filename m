From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 11:57:58 +0100
Subject: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
In-Reply-To: <20150812104436.GA19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
 <20150812104436.GA19600@pengutronix.de>
Message-ID: <20150812105758.GU10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:44:36PM +0200, Markus Pargmann wrote:

> I wasn't aware that any 64 bit architecture actually has unsigned ints
> that are 64 bit in size. So wouldn't at least on x86_64 this would lead
> to a compiler warning as unsigned int is 4 byte and u64 8 bytes?

Nobody complained about warnings yet.  The compiler probably shouldn't
be complaining given the casts, they're supposed to be an "I know what
I'm doing" thing.  If you want to change something here it's changing
the test to be based on sizeof(unsigned int).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/a6280ed6/attachment.sig>
