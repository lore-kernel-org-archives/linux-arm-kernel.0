From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Jan 2013 08:53:23 +0100
Subject: [PATCH 1/2 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
References: <1358914330-3768-1-git-send-email-Frank.Li@freescale.com>
 <20130123072635.GO1906@pengutronix.de>
 <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
Message-ID: <20130123075323.GU1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 03:44:53PM +0800, Frank Li wrote:
> > This comment seems rather unnecessary. Also it should be
> >
> >         /* space left and right /*
> >
> > devicetree bindings should use '-' instead of '_'. The binding
> > Documentation should be in the patch adding the bindings. Also
> > make sure the devicetree parsing is outside of the path for platform
> > based probing.
> >
> > With this particular binding I'm unsure it should exist anyway since
> > it's configuration rather than hardware description. The devicetree
> > normally is for hardware description only.
> >
> 
> What's your opinion?
> Using module parameter, device-tree to config it or the other method?

Why do you want to make it configurable anyway? So far no other driver
seems to need this. My suggestion is to make it unconfigurable.

For adding properties like this to the devicetree remember that they
should be OS agnostic. napi is a implementation detail relevant only
for Linux. And even Linux may decide to drop napi support in favour for
something better in the future.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
