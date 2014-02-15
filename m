From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 15 Feb 2014 17:39:09 -0500 (EST)
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <201402152212.02580.arnd@arndb.de>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <2979047.tn4oVevojb@wuerfel> <20140215135930.GA26088@lunn.ch>
 <201402152212.02580.arnd@arndb.de>
Message-ID: <alpine.LFD.2.11.1402151735300.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 15 Feb 2014, Arnd Bergmann wrote:

> On Saturday 15 February 2014, Andrew Lunn wrote:
> > None of the _defconfig's ever turn on
> > CACHE_FEROCEON_L2_WRITETHROUGH. I also did a quick google and could
> > not find any usage of it.
> > 
> > So i see two options:
> > 
> > 1) Remove the wr-override from the DT binding and use
> > CACHE_FEROCEON_L2_WRITETHROUGH.
> > 
> > 2) Remove CACHE_FEROCEON_L2_WRITETHROUGH and make proc-feroceon.S do
> > the right thing at runtime.
> > 
> > I suspect i will go for 1), it is simpler.
> 
> Yes, fair enough. I'd hope we could just kill the option altogether,
> but it's probably hard to find anyone who would remember what it
> was introduced for, unless Nico knows.

There was a time when we didn't know what cache mode was the best 
performance wise.  The right answer is "it depends on the work load" of 
course.  Hence it was made optional for people to play with and choose 
for themselves.


Nicolas
