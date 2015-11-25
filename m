From: eric@anholt.net (Eric Anholt)
Date: Wed, 25 Nov 2015 11:33:26 -0800
Subject: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <20151124210249.GA4270@omega>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
 <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com>
 <20151124210249.GA4270@omega>
Message-ID: <8737vt27sp.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> Hi,
>
> On Tue, Nov 24, 2015 at 09:44:59PM +0100, Ulf Hansson wrote:
>> [...]
>> 
>> > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> > index 8c53c55..20479d7 100644
>> > --- a/arch/arm/mach-bcm/Kconfig
>> > +++ b/arch/arm/mach-bcm/Kconfig
>> > @@ -134,6 +134,16 @@ config ARCH_BCM2835
>> >           This enables support for the Broadcom BCM2835 SoC. This SoC is
>> >           used in the Raspberry Pi and Roku 2 devices.
>> >
>> > +config RASPBERRYPI_POWER
>> 
>> You don't need a new Kconfig option I think. If you fold in the below
>> "select" under ARCH_BCM2835, that should work as well, right?
>> 
>> select PM_GENERIC_DOMAINS if (RASPBERRYPI_FIRMWARE && PM && OF)
>> 
>
> I think this depends on what the maintainers like to have here.
>
> The raspberrypi firmware isn't BCM2835 specific, when some SoC which is
> BCM2835 and enabled the RASPBERRYPI_FIRMWARE (for what reason ever) it will
> enable also the power domain driver for the RPi.
>
> When some BCM2835 enable it, then it will do nothing because the
> devicetree entries should not match then.

As far as I'm concerned, using the firmware is a stopgap to get other
drivers working, until we can get a native power domain driver written.
I think it makes sense for this code to be under its own menu entry, so
it can be flipped back off when we get the real thing in place.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151125/5a5f0a62/attachment.sig>
