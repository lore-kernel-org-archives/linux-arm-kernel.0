From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2012 08:43:50 +0000
Subject: In many cases softlockup can not be reported after disabling
 IRQ for long time
In-Reply-To: <CAOwKts8S0EkUGcP3rYqZe+HdvyXD0+SR1f_3xWpu5FprKWuGhQ@mail.gmail.com>
References: <CAOwKts8zS1rYA+Y4k-vb8YAaR=aFd1BwryhhWWnWLQyrYrNqyA@mail.gmail.com>
 <20120131154748.GA5650@redhat.com>
 <CAOwKts_dTvc4LiCZUXN9oYzty1pkDEn_VQwPKY=EoVzk0n6tFA@mail.gmail.com>
 <20120201145802.GF5650@redhat.com>
 <CAOwKts8S0EkUGcP3rYqZe+HdvyXD0+SR1f_3xWpu5FprKWuGhQ@mail.gmail.com>
Message-ID: <20120202084350.GB1275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

.sdrawkcab esra s'ti ,tsop pot t'noD

(Don't top post, it's arse backwards.)

On Thu, Feb 02, 2012 at 04:17:02PM +0800, TAO HU wrote:
> My concern is not actually that the softlockup could not be reported
> while the IRQ is disabled.
> What bothering me is that even AFTER re-enable the IRQ, it will not
> give warning in many cases.

That's already been explained.

softlockups are detected by time passing.  Time can't properly advance
with interrupts disabled, as the backing counter (assuming you're using
the clocksource and clockevent stuff) could wrap.  If it wraps, the
systems idea of time which has passed will be incorrect.

So, if interrupts are disabled for a long period, the system loses track
of time, and therefore can't know how long the system has been blocked for.
