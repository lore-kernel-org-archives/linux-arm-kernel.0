From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 19:36:24 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <16507628.c6raaN50oI@wuerfel>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4494372.fAWcxQ0qku@wuerfel> <53C402C4.5090908@metafoo.de>
 <16507628.c6raaN50oI@wuerfel>
Message-ID: <20140714183624.GV6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:

> > Yes. But now that you say it the gpiod_direction_output() call is missing 
> > from this patch.

> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/board.txt
> and as Linus Walleij explained to me the other day, the lookup is supposed
> to replace devm_gpio_request_one(), which in turn replaced both the
> gpio_request and the gpio_direction_output(). Do I need to put the
> gpiod_direction_output() back or is there another interface for that when
> registering the board gpios?

Indeed.  If you *do* need an explicit _output() then that sounds to me
like we either need a gpiod_get_one() or an extension to the table,
looking at the code it seems like this is indeed the case.  We can set
if the GPIO is active high/low, or open source/drain but there's no flag
for the initial state.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/e30fb34a/attachment.sig>
