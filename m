From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 15:31:04 +0400
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
In-Reply-To: <20130720111639.GA29785@pengutronix.de>
References: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
 <20130720111639.GA29785@pengutronix.de>
Message-ID: <20130720153104.96b6723a20bde172a8ea1ba1@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Jul 2013 13:16:39 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Sat, Jul 20, 2013 at 12:29:35PM +0400, Alexander Shiyan wrote:
> > This patch implements frequency change for i.MX pllv1.
> > Selection of the values of the registers is not optimal, since is
> > made by simple enumeration of all possible values.
> 
> You do not mention why you want to adjust the rate. Normally we've been
> happy with the static values from the bootloader.

For CPUfreq.
Only one barrier to make it workable.

[...]
> > +	/* Avoid i.MX27 TO2 SPCTL0 bug */
> > +	if (cpu_is_mx27() && (mx27_revision() == IMX_CHIP_REVISION_2_0))
> > +		writel(reg, pll->base);
> 
> I remember this was fixed and got lost. If you want to have fixed it
> again this should be a separate paatch along with a description of the
> bug in the commit log.

This part of the patch can be completely removed ;)
I'm more interested in a more efficient algorithm for finding the best
values for the PLL.

[...]

-- 
Alexander Shiyan <shc_work@mail.ru>
