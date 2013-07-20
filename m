From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 16:18:01 +0400
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
In-Reply-To: <20130720115829.GD29785@pengutronix.de>
References: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
 <20130720111639.GA29785@pengutronix.de>
 <20130720153104.96b6723a20bde172a8ea1ba1@mail.ru>
 <20130720115829.GD29785@pengutronix.de>
Message-ID: <20130720161801.380bb0d9db75155f5401730b@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Jul 2013 13:58:29 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> > > On Sat, Jul 20, 2013 at 12:29:35PM +0400, Alexander Shiyan wrote:
> > > > This patch implements frequency change for i.MX pllv1.
> > > > Selection of the values of the registers is not optimal, since is
> > > > made by simple enumeration of all possible values.
> > > 
> > > You do not mention why you want to adjust the rate. Normally we've been
> > > happy with the static values from the bootloader.
> > 
> > For CPUfreq.
> > Only one barrier to make it workable.
> 
> Isn't it better to adjust the dividers only? I haven't made good
> experience with adjusting the PLLs.

The frequency value after booting can be quite arbitrary.

Since we define possible frequencies for the CPU (266 and 399 MHz),
I can offer as variant to use a fixed constant values for PLL.

-- 
Alexander Shiyan <shc_work@mail.ru>
