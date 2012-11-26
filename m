From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 26 Nov 2012 16:10:35 +0000
Subject: [PATCH 1/2] leds: Add generic support for memory mapped LEDs
In-Reply-To: <CA+E=qVcjKz-3CAKrDVG+ymij5HAB5H=a9+4G0KOR0tTKLGJu4w@mail.gmail.com>
References: <1351792722-15250-1-git-send-email-pawel.moll@arm.com>
 <CA+E=qVcjKz-3CAKrDVG+ymij5HAB5H=a9+4G0KOR0tTKLGJu4w@mail.gmail.com>
Message-ID: <1353946235.10271.11.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-26 at 15:37 +0000, Vasily Khoruzhick wrote:
> On Thu, Nov 1, 2012 at 8:58 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> > LEDs are often controlled by writing to memory mapped
> > register. This patch adds:
> >
> > 1. Generic functions for platform code and drivers to create
> >    class device for LEDs controlled by arbitrary bit masks.
> >    The control register value is read, modified by logic AND
> >    and OR operations with respective mask and written back.
> >
> > 2. A platform driver for simple use case when one or more LED
> >    are controlled by consecutive bits in a register pointed
> >    at by the platform device's memory resource. It can be
> >    particularly useful for MFD cells being part of an other
> >    device.
>
> This MMIO controls some latch (or whatever) which is actually GPIO.
> So implementing generic GPIO MMIO driver and using leds-gpio on top of
> it appears to be a better solution for me.

I won't argue that it is doable - I don't even have to implement the
MMIO GPIO driver, because my MFD already has a set of pseudo-GPIO lines
and extending those won't be a problem at all an I'll do exactly that if
there is no other choice. But at the same time I hope you would agree
that my_code->gpio_controller->gpio_led_description->register_device
chain is longer than my_code->mmio_led one if you want to add a single
"status" led for your little board ;-). I don't event mention that at
least couple of the existing drivers follow the same "MMIO pattern"
blindly.

Nevertheless I'd really like to hear from the maintainers...

Thanks!

Pawe?
