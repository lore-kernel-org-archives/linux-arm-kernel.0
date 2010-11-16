From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Nov 2010 21:58:05 +0100
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <20101116203520.GE21926@n2100.arm.linux.org.uk>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
	<20101116182643.GC21926@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1011161517260.6448@xanadu.home>
	<20101116203520.GE21926@n2100.arm.linux.org.uk>
Message-ID: <20101116205805.GW8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 16, 2010 at 08:35:20PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 16, 2010 at 03:28:44PM -0500, Nicolas Pitre wrote:
> > On Tue, 16 Nov 2010, Russell King - ARM Linux wrote:
> > > Not used anymore - it's practically zero (and unused) for most cases
> > > now anyway.
> > 
> > I think it is worth preserving this layout regardless.  First of all 
> > this is really cheap to do, and if whatever bootloader out there is 
> > relying on it, at least the magic number, then better not break it 
> > freely.
> 
> It's already broken by the relocatable format - which has zero as the
> start address.  That's been in for a few years now, and no one even
> noticed that this header ended up with zero as the entry address.
> Therefore, I suggest that no one at all is using it.
I remember me creating a patch for U-Boot that ignored the uImage
header's load and entry address if it was an ARM-Linux image and the
linux header had the right magic and the entry address was zero.  I
don't know anything about it's current state, but it might still ship
with Digi's BSP.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
