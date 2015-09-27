From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 27 Sep 2015 16:34:52 +0200
Subject: [PATCH v2 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <CACRpkdb4EoA_oBSF46eYAZ-fbTEqaf=Q+wsGyKyrQZ9KB2B7cQ@mail.gmail.com>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-3-git-send-email-mpa@pengutronix.de>
 <CACRpkdZrXEXtkPpgtrcjqP5jD+M0UOj5Wj69o4zYJQKihsY6Xg@mail.gmail.com>
 <20150924063931.GS32203@pengutronix.de>
 <CACRpkdb4EoA_oBSF46eYAZ-fbTEqaf=Q+wsGyKyrQZ9KB2B7cQ@mail.gmail.com>
Message-ID: <20150927143452.GF19121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 10:52:55AM -0700, Linus Walleij wrote:
> On Wed, Sep 23, 2015 at 11:39 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> >> - Fixed that but noted that it just alters the call to gpiod_hog()
> >>   in of_gpiochip_scan_hogs(), there is a local const char *name that
> >>   should be removed too.
> >
> > The local const char *name is temporarily used in
> > of_gpiochip_scan_hogs() to get the name from DT and assign it to the
> > descriptor:
> >         desc = of_parse_own_gpio(np, &name, &lflags, &dflags);
> >         ...
> >         else
> >                 desc->name = name;
> 
> OK the problem is that this series is dependent on the
> named GPIOs series. I want this series to stand alone,
> because this series is not as controversial, and I want to
> merge these initvals first.

OK, I think I won't get this completely independent but it shouldn't be
a problem to get this before the controversial patches. Will do that.

Best Regards,

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150927/059e5a81/attachment-0001.sig>
