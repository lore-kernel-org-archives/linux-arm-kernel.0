From: david-b@pacbell.net (David Brownell)
Date: Tue, 7 Sep 2010 11:10:14 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <4C85BEFD.402@bluewatersys.com>
Message-ID: <569801.35222.qm@web180310.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Mon, 9/6/10, Ryan Mallon <ryan@bluewatersys.com> wrote:

> >  The intent of my patch was to keep gpio_is_valid
> simple, but add
> a simple check for architectures where the base gpio is not
> zero. Will
> wait and see what David has to say.

NAK still.  You're trying to abuse gpio_is_valid(),
which I see no need to support.


In terms of GPIO framework architecture, zero is
the first GPIO in all cases, and is always
a valid GPIO number, even if it's not
requestable/swritable/readable on a given board.

Whether it's usable on a given platform depends
on whether a GPIO controller is registered which
claims numbers 0..N ... (assuming gpiolib in use).
