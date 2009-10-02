From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 2 Oct 2009 09:32:05 +0200
Subject: 2.6.32-rc1: spitz boots but suspend/resume is broken
In-Reply-To: <20091002041015.GB1409@ucw.cz>
References: <20090930120655.GG1412@ucw.cz>
	<bc64b4640909300509p6c682fa8rb5ce43c77c79f5@mail.gmail.com>
	<20091002041015.GB1409@ucw.cz>
Message-ID: <20091002073205.GA23986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 02, 2009 at 06:10:15AM +0200, Pavel Machek wrote:
> On Wed 2009-09-30 16:09:25, Dmitry Eremin-Solenikov wrote:
> > On Wed, Sep 30, 2009 at 4:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > > Hi!
> > >
> > > matrix keyboard driver needs to be enabled, otherwise it seems ok.
> > >
> > > Unfortunately, it does not respond to power button in any visible way
> > > :-(. Any ideas what might be wrong/how to debug it?
> > 
> > Enable gpio-keyboard driver, verify (or port power button to it :))
> > and check that
> > enable_wakeup is enabled.
> 
> It seems neccessary tables for gpio-keyboard just are not there :-(.
> 
> In the meantime, this allows easy switch to known-good driver. (Can we
> get it upstream until problem is fixed properly?)
> 
> Unfortunately, that still does not fix suspend/resume. (Does it work
> for you?)

Are you using the serial console on spitz? If yes, this might be
interesting for you:

http://bugzilla.kernel.org/show_bug.cgi?id=14297

I ended up with a console with 9600 baud after resume. My system resumed
correctly, but I did not see anything.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
