From: ada@thorsis.com (Alexander Dahl)
Date: Wed, 12 Jul 2017 18:28:09 +0200
Subject: [RFC 0/3] net: macb: Use SRAM on SoC for RX rings and buffers
Message-ID: <1499876892-14423-1-git-send-email-ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei hei,

this is a small patch series for a problem we encoutered with a board
based on an AT91SAM9G20 SoC. I talked about it a few days ago on the
#armlinux IRC channel with Alexandre Belloni and Florian Fainelli. The
current state of those patches is 'prove of concept', but if this is
useful for someone I would like to get it upstream.

The first two patches are just adding some descriptive comments for
register and bit definitions, taken from the at91sam9g20 hardware
manual. Those may be of general interest, even without the third
patch.

The third patch is the main one. I tried to describe in the commit
message as clear as possible what problem is to be solved. If you
don't understand the reason please ask, I will happily change or
extend the message.

Regarding the third patch: It's just a proof of concept so far, I
changed some hardcoded values which probably should not be that low
for the normal usecase with RX buffers/rings in SD-RAM/DDR-RAM. It
would be good if this would be somehow configurable at boot time, so
maybe in device tree. However I would need an idea how to do this and
some help, that's why this series is just RFC.

I tested this with heavy load on the EBI bus (external SRAM), network
seems to work as usual and I get no receive overrun errors anymore.

An interesting question for me would be where this mac is used and
whether internal sram is available on those SoCs and in what sizes
(sam9g20 has 32k). A quick view in arch/arm/boot/dts just showed my
at91sam9 and sama5 platforms using the macb driver.

Greets
Alex
