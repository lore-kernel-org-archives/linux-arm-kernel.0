From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 24 Aug 2014 16:37:30 +0200
Subject: [v4] watchdog: Add DA906x PMIC watchdog driver.
In-Reply-To: <20140821141959.GA26019@roeck-us.net>
References: <1408192545-23987-1-git-send-email-mpa@pengutronix.de>
 <20140820144322.GA7609@roeck-us.net>
 <20140821061525.GA23823@pengutronix.de>
 <20140821141959.GA26019@roeck-us.net>
Message-ID: <20140824143730.GC23823@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 21, 2014 at 07:19:59AM -0700, Guenter Roeck wrote:
> On Thu, Aug 21, 2014 at 08:15:25AM +0200, Markus Pargmann wrote:
> > Hi,
> > 
> ...
> > > > +static int da9063_wdt_timeout_to_sel(int secs)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = DA9063_TWDSCALE_MIN; i <= DA9063_TWDSCALE_MAX; i++) {
> > > 
> > > When building with W=1, gcc complains about this line. Would be great if you can
> > > have a look and fix it.
> > 
> > I just compiled with W=1, it doesn't complain here about this line.
> > Could you give me the warning?
> > 
> drivers/watchdog/da9063_wdt.c: In function 'da9063_wdt_timeout_to_sel':
> drivers/watchdog/da9063_wdt.c:48:34: warning: comparison between signed and
> unsigned integer expressions [-Wsign-compare]
> 
> This is with arm-poky-linux-gnueabi-gcc (GCC) 4.7.2.

Thanks, I am using gcc 4.8.3. I replaced the used 'int' type by 'unsigend
int', that should fix it.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140824/7006bf5a/attachment.sig>
