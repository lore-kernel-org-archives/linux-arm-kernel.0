From: david-b@pacbell.net (David Brownell)
Date: Mon, 6 Sep 2010 19:23:22 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <20100903164158.GH17702@game.jcrosoft.org>
Message-ID: <280328.53116.qm@web180311.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Still not liking or accepting this proposed
change to the GPIO framework.

For the AT91 case (where integers 0..N are
IRQs, but N..max are GPIOs)

A simpler solution is just to use a bit in
the integer to indicate IRQ vs GPIO.  Like
maybe the sign bit.. which is never set on
valid GPIO numbers, but platforms could let
be set on IRQs.
