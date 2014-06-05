From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Jun 2014 19:55:01 -0700
Subject: [PATCH] serial: samsung: fix typo in debug code
In-Reply-To: <1401931241.26329.16.camel@joe-AO725>
References: <10455941.RzodM59Z3O@wuerfel> <1401931241.26329.16.camel@joe-AO725>
Message-ID: <20140605025500.GA27555@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 06:20:41PM -0700, Joe Perches wrote:
> On Tue, 2014-06-03 at 11:53 +0200, Arnd Bergmann wrote:
> > commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
> > a regression in the conversion from vsprintf to vsnprintf.
> > 
> > This fixes the build error by passing the correct variable name.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > 
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index 3293377..c1d3ebd 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
> >  	char buff[256];
> >  
> >  	va_start(va, fmt);
> > -	vscnprintf(buff, sizeof(buf), fmt, va);
> > +	vscnprintf(buff, sizeof(buff), fmt, va);
> >  	va_end(va);
> >  
> >  	printascii(buff);
> 
> Greg?
> 
> The original has ended up in Linus' -next branch.
> 
> Can you please apply this sooner rather than later?

Let me work through these 3.4-stable patches first, so give me a day or
so, thanks.

greg k-h
