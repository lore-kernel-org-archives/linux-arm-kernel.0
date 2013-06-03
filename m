From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Jun 2013 20:43:38 +0200
Subject: [PATCH] serial: omap: repair building without PM_SLEEP
In-Reply-To: <20130603170730.GA30767@kroah.com>
References: <1844339.mxci2DdvBF@wuerfel> <20130603170730.GA30767@kroah.com>
Message-ID: <201306032043.38656.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013, Greg Kroah-Hartman wrote:
> On Sat, Jun 01, 2013 at 11:18:13AM +0200, Arnd Bergmann wrote:
> > A recent bug fix in 3.10, ddd85e225c "serial: omap: prevent runtime PM for
> > "no_console_suspend"", introduced a regression from an obvious typo:
> 
> I don't see that commit id, or commit, in Linus's tree at all.  Where do
> you see it?
> 
> > drivers/tty/serial/omap-serial.c:1677:14: error: 'serial_omap_complete' 
> >       undeclared here (not in a function)
> > 
> > This changes the incorrectly added macro to the one that we need instead.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Please apply for 3.10-rc
> 
> Really?  It doesn't apply to 3.10-rc3 or -rc4 from what I can tell.

Sorry, my mistake. Since the bug was introduced as part of a bug fix
I assumed it was in 3.10-rc but did not look carefully. The problem
only exists in tty-next at the moment.

	Arnd
