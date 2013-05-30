From: pavel@denx.de (Pavel Machek)
Date: Thu, 30 May 2013 12:38:44 +0200
Subject: [PATCH v7] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51A68CF8.7000303@wwwdotorg.org>
References: <1369753575-9818-1-git-send-email-p.zabel@pengutronix.de>
 <51A68CF8.7000303@wwwdotorg.org>
Message-ID: <20130530103843.GB24712@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-05-29 17:19:20, Stephen Warren wrote:
> On 05/28/2013 09:06 AM, Philipp Zabel wrote:
> > This driver implements a reset controller device that toggle a gpio
> > connected to a reset pin of a peripheral IC. The delay between assertion
> > and de-assertion of the reset signal can be configured via device tree.
> 
> > diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c
> 
> > +static void __gpio_reset_set(struct reset_controller_dev *rcdev, int asserted)
> 
> Nit: Technically I think __ is a reserved name-space, so you shouldn't
> prefix "user-level" (rather than libc/similar) symbols with it, but it's
> not a big deal.

Well.. this is kernel :-). We don't have libc around... and this
standard is normally ignored here. __ is normally used as a prefix for
"simpler" function.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
