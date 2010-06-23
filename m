From: david-b@pacbell.net (David Brownell)
Date: Wed, 23 Jun 2010 05:40:01 -0700 (PDT)
Subject: gpiolib and sleeping gpios
In-Reply-To: <alpine.DEB.2.00.1006231435410.8344@wnav-qrfxgbc>
Message-ID: <564390.64703.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 6/23/10, Jani Nikula <ext-jani.1.nikula@nokia.com> wrote:

> Hi David -
> 
> Part of the reason why such drivers haven't been fixed
> might be that the runtime warnings are only issued if DEBUG
> is defined in gpiolib.c:

A very good point.  those cansleep() warnings
should perhaps be issued more consistently.

(Other warnings are safer to skip.)

I think the normal case for the GPIO calls is
the spinlock-safe code path, so I'd probably
ack a patch which incurs the extra costs only
for gpio chips that are already sleeping.

(The desire to trim costs for bitbanging is
not going to affect gpio chips accesssed over
I2C or SPI ... ;)

- Dave
