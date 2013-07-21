From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 21 Jul 2013 14:37:59 +0200
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
In-Reply-To: <20130720161801.380bb0d9db75155f5401730b@mail.ru>
References: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
 <20130720111639.GA29785@pengutronix.de>
 <20130720153104.96b6723a20bde172a8ea1ba1@mail.ru>
 <20130720115829.GD29785@pengutronix.de>
 <20130720161801.380bb0d9db75155f5401730b@mail.ru>
Message-ID: <20130721123759.GJ29785@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 04:18:01PM +0400, Alexander Shiyan wrote:
> On Sat, 20 Jul 2013 13:58:29 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > > > On Sat, Jul 20, 2013 at 12:29:35PM +0400, Alexander Shiyan wrote:
> > > > > This patch implements frequency change for i.MX pllv1.
> > > > > Selection of the values of the registers is not optimal, since is
> > > > > made by simple enumeration of all possible values.
> > > > 
> > > > You do not mention why you want to adjust the rate. Normally we've been
> > > > happy with the static values from the bootloader.
> > > 
> > > For CPUfreq.
> > > Only one barrier to make it workable.
> > 
> > Isn't it better to adjust the dividers only? I haven't made good
> > experience with adjusting the PLLs.
> 
> The frequency value after booting can be quite arbitrary.
> 
> Since we define possible frequencies for the CPU (266 and 399 MHz),
> I can offer as variant to use a fixed constant values for PLL.

AFAIK the PLL should run at 800MHz. With dividers of 2, 3 and 6 we get
400, 266 and 133MHz. I don't think having more fine grained control
about the CPU frequency is necessary from a power saving point of view.
Let's keep the variants to a minimum to make the whole stuff more
robust.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
