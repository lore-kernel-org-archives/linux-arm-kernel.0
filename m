From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Feb 2015 17:43:16 +0900
Subject: [PATCH] ASoC: improve usage of gpiod API
In-Reply-To: <1424532804-23789-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424532804-23789-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150224084316.GA6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 21, 2015 at 04:33:24PM +0100, Uwe Kleine-K?nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for
> output. Simplify drivers accordingly.

Applied, thanks.  However...

>  sound/soc/codecs/adau1977.c | 17 +++++------------
>  sound/soc/codecs/cs35l32.c  | 19 ++++++-------------
>  sound/soc/codecs/cs4265.c   | 19 ++++++-------------
>  sound/soc/codecs/sta350.c   | 30 +++++++++---------------------
>  sound/soc/codecs/tas2552.c  | 13 +++----------
>  5 files changed, 29 insertions(+), 69 deletions(-)

...as this touches a bunch of drivers it would have been nicer to send
it as a series of changes - that minimizes the risk of collisions with
other changes as a problem with one driver won't affect the others.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/c5b7e4da/attachment.sig>
