From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Sep 2016 14:20:57 -0700
Subject: [PATCH 1/8] ARM: dts: bcm283x: Define standard pinctrl groups in
 the gpio node.
In-Reply-To: <1473411924.6698.85.camel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-2-git-send-email-kraxel@redhat.com>
 <1628308726.55593.220fafc0-57d9-4317-a72d-0875dfb2d658.open-xchange@email.1und1.de>
 <1473411924.6698.85.camel@redhat.com>
Message-ID: <8737l893d2.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e<#secure method=pgpmime mode=sign>
Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> According to this page [1] the pinctrl group for parallel display interface is
>> missing. Is it intended?
>> 
>> [1] - http://elinux.org/RPi_BCM2835_GPIOs
>
> Just an oversight I guess.  Eric?
>
> Does this look correct?
>
> +                       dpi_gpio4: dpi_gpio4 {
> +                               brcm,pins = <4 5 6 7 8 9 10 11 12 13
> +                                            14 15 16 17 18 19 20 21
> +                                            22 23 24 25 26 27>;
> +                               brcm,function = <BCM2835_FSEL_ALT2>;
> +                       };

For DPI, you also need pins 0-3 in there for clock and syncs.

That set of data pins would be for a 24-bit mode, which is what we
should be using for the Adafruit kippah + 7" panel combo.
