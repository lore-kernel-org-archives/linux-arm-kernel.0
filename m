From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Nov 2015 20:03:29 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for the
 lamobo-r1 board
In-Reply-To: <D279EE2F.E5EF6%Thomas.Kaiser@kaiser-edv.de>
References: <1448046713-13579-1-git-send-email-hdegoede@redhat.com>
 <20151122195925.GR32142@lukather> <5652CE10.1020808@redhat.com>
 <D279EE2F.E5EF6%Thomas.Kaiser@kaiser-edv.de>
Message-ID: <20151130190329.GD3664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 10:45:27AM +0100, Thomas Kaiser wrote:
> Hi,
> 
> Hans de Goede wrote:
> 
> > The Lamobo-R1 has a gpio header idententical to the one found
> > on the Banana Pi, i2c2 is routed to pins there.
> 
> That's the reason this header exists in this form and that's the reason
> customers buy these boards that expose an 'RPi compatible' 26/40 pin GPIO
> header. That applies also to the various Orange Pi's and other
> $insert-your-favourite-fruit-here Pi  with different SoCs, eg.
> Roseapple/Lemon Pi with Actions Semi's S500. Even boards that do not share
> the RPi's naming scheme feature this GPIO header, eg. LeMaker's Guitar or
> ODROID C1/C1+
> 
> Users expect this GPIO header being 'RPi compatible' regarding
> hardware-Addons (RPi HATs), software support (each of the above boards has a
> ported WiringPi lib) and tutorials they find on the net.

The point is that it's *not* a GPIO header, and it's even worse that
that, if you actually want to use a GPIO on that header, you just
can't.

> Breaking this compatibility with mainline kernel is not a good idea
> IMO.

This compatibility is a fallacy in the first place. It might be an
electrical one, but it's certainly not a software one. How do you deal
with alternative pin configuration? How do you deal with the GPIOs
toggling? Which i2c bus is routed on this header?

And that wouldn't break anything. Quite the opposite actually, it
would allow people that want to deviate from the standard to do so
while allowing people that want to follow that standard to do so as
well.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/ade6b2ac/attachment.sig>
