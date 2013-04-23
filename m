From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 23 Apr 2013 23:22:25 +0200
Subject: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
In-Reply-To: <87sj2iteue.fsf@octavius.laptop.org>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
 <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
 <87wqrutjss.fsf@octavius.laptop.org>
 <20130422203723.GI29947@lunn.ch>
 <20130422210949.GJ25724@titan.lakedaemon.net>
 <20130422214543.GJ29947@lunn.ch>
 <87sj2iteue.fsf@octavius.laptop.org>
Message-ID: <20130423212224.GA29507@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris, Guennadi,

On Mon, Apr 22, 2013 at 05:50:17PM -0400, Chris Ball wrote:
> Hi,
> 
> On Mon, Apr 22 2013, Andrew Lunn wrote:
> >> Nothing else really jumps out though.  Where either of these what you
> >> were thinking of?
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138514.html
> >
> > and
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138513.html
> 
> These patches move mvsdio to slot-gpio, which is a prerequisite for
> using the shared mmc_of_parse(), but they don't go all the way to
> using mmc_of_parse().

That's nice functionality, I was not aware of that. I will convert this
to mmc_of_parse() once I find some time.

One question already: Why does mmc_of_parse() not return errors to
the caller?  If, for example, a GPIO line was given for CD in the DT,
but it could not be obtained, shouldn't the caller at least have the
possibility to handle this as an error?  (mvsdio currently
aborts the probe if it can't get the GPIO line).

- Simon
