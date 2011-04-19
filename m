From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Apr 2011 00:24:20 +0100
Subject: [PATCH] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <20110419161913.a1c18599.akpm@linux-foundation.org>
References: <20110405073030.GI13963@pengutronix.de>
	<1301992655-8514-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110405163338.GA11832@n2100.arm.linux.org.uk>
	<20110419161913.a1c18599.akpm@linux-foundation.org>
Message-ID: <20110419232420.GA3673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 04:19:13PM -0700, Andrew Morton wrote:
> On Tue, 5 Apr 2011 17:33:39 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Tue, Apr 05, 2011 at 10:37:35AM +0200, Uwe Kleine-K__nig wrote:
> > > +struct platform_device *__init gpio_led_register_device(
> > > +		const struct gpio_led_platform_data *pdata);
> > 
> > Please don't add __init annotations to declarations.
> 
> Reasons?

It's noise.

> A year or so ago we had to *add* an __init to a declaration, because
> one architecture was generating a short-mode-addressing relative branch
> to the callee, assuming the target was in the same section as the call
> site.  When the linker went to resolve the branch, it discovered that
> the target was in fact in a different section and was too far away to
> be able to use the short-mode addressing.  IIRC, that architecture was
> arm.

I'm not aware of ARM ever requiring that.  If it was, we'd have to add
a heck of a lot of those annotations.  And those annotations don't tell
the compiler that it might be far away.

We _do_ have a problem if someone decides to include a big ramdisk or
initramfs image in the discarded section, which is something I have a
patch kicking around to completely change the vmlinux layout to resolve.
That's taking something of a low priority at the moment though as we've
been turned upside down by Linus...
