From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Mar 2011 08:53:56 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
Message-ID: <20110302085356.GB4493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 10:29:37PM +0100, Thomas Gleixner wrote:
> Errm. I did never say that we disable the parent interrupt by any
> means except when the chained handler explicitely wants to do that,
> which is pretty much pointlesss nowadays, as we run all interrupt
> handlers with interrupts disabled.

And that's now why some platforms struggle to work, and we're having
to bodge around this - like the ARM platforms with MMC support.  Like
some other platforms where having IRQs disabled during IDE prevents
interrupts being recevied for long periods of time (longer than the
100Hz tick period).

I *violently* disagree with the direction that genirq is heading.  It's
*actively* breaking stuff.  What's really annoying is that problems like
the above I did point out, but you seem happy to completely ignore them.
The result is that more and more ARM platforms *are* becoming utterly
useless, or requiring additional complexity being shoved into subsystems
to cope with this crap.

What we need is a *decent* IRQ support system.  Not something created out
of religious arguments which is what we have now.
