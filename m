From: david-b@pacbell.net (David Brownell)
Date: Sun, 20 Jun 2010 19:40:46 -0700 (PDT)
Subject: gpiolib and sleeping gpios
In-Reply-To: <4C1E88AE.5070808@bluewatersys.com>
Message-ID: <887171.45295.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Sun, 6/20/10, Ryan Mallon <ryan@bluewatersys.com> wrote:


> >> The point I was trying to make is that
> >> there are lots of drivers which
> >> will not work with gpios on sleeping io expandersbecause they call the
> >> spinlock safe gpio calls.

"Lots"?  You mean there are lots of
maintainers who aren't even bothering to
provide trivial fixes for bug which are
clearly reported to them by warnings?
These one-liner fixes are not hard...

Such problems are people-problems, not issues
with any framework. 
> > 
> > And they will trigger runtime warnings, and
> > thus eventually get fixed.
> \
> ? }
> 
> ? err = gpio_request(some_gpio, "some_gpio",
>           GPIOF_NO_SLEEP);


NAK ... keep it simple.  Such flags are
clearly not necessary...

I understand that some folk are bothered
by concepts/frameworks that seem "too simple"
and thus want to complexify them.  In this
case I am in a position to help avoid that.
Complexity is not a virtue.
