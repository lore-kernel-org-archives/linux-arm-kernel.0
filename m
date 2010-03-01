From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Mar 2010 10:07:14 +0100
Subject: [PATCH 3/3] MAINTAINERS: add i2c tree for embedded platforms
In-Reply-To: <20100228155754.GC16745@n2100.arm.linux.org.uk>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100228155754.GC16745@n2100.arm.linux.org.uk>
Message-ID: <20100301090714.GB29952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 28, 2010 at 03:57:54PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 24, 2010 at 12:01:46PM +0100, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  MAINTAINERS |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2533fc4..a3c936c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2626,6 +2626,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> >  L:	linux-i2c at vger.kernel.org
> >  W:	http://i2c.wiki.kernel.org/
> >  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
> > +T:	git git://git.fluff.org/bjdooks/linux.git
> 
> This is wrong.  This is the same tree which I pull ARM stuff from, so it
> needs qualifying with a branch name.
$(git ls-remote git://git.fluff.org/bjdooks/linux.git) suggests two
candidates:

	for-linus/i2c
	next-i2c

And I think for now this is only parsed by humans and everbody should be
able to notice that e.g. "next-s3c" doesn't contain i2c patches in the
presence of the two above branches.

So unless there is a syntax to specify more than one branch I suggest to
keep it as is.  Or should we only list next-i2c?  Ben, what do you
think?

(Maybe we can just make it:

	T: git git://git.fluff.org/bjdooks/linux.git for-linus/i2c
	T: git git://git.fluff.org/bjdooks/linux.git next-i2c

but this is a bit too much IMHO.  (Who volunteers to list all branches
of tip in MAINTAINERS? ;-))

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
