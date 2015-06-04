From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jun 2015 10:42:48 +0100
Subject: [PATCH 10/11] spi: add more debug prints in s3c64xx
In-Reply-To: <CAMuHMdWHPm6exq4O3CNvVuiZOgLHuxyCrR548BFmbOPikvNRLw@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
 <CAMuHMdWHPm6exq4O3CNvVuiZOgLHuxyCrR548BFmbOPikvNRLw@mail.gmail.com>
Message-ID: <20150604094248.GA14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 11:30:15AM +0200, Geert Uytterhoeven wrote:
> On Thu, Jun 4, 2015 at 11:16 AM, Mark Brown <broonie@kernel.org> wrote:
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -18,6 +18,7 @@
> >>  #include <linux/interrupt.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/clk.h>
> >> +#include <linux/clk-provider.h>

> > Whatever you're doing here this indicates that there's a very big
> > abstraction problem going on.

> I guess it's needed for __clk_get_name(), which can be avoided by using
> the "%pC" printf format specifier instead.

Right, or by adding an externally usable API - the point is that using
internal functions in a client driver is a big red flag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/64516a5f/attachment-0001.sig>
