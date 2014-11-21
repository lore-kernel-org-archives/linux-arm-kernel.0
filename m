From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 21:12:29 +0100
Subject: [PATCH 4/9] clk: Add clock driver for mb86s7x
In-Reply-To: <CAJe_Zhc2UePxy-Y2LsU1Pn18OOknDKZw-8rjJ06DEWOhvs6CMw@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <5451217.D7Cssxh5Uh@wuerfel>
 <CAJe_Zhc2UePxy-Y2LsU1Pn18OOknDKZw-8rjJ06DEWOhvs6CMw@mail.gmail.com>
Message-ID: <4948551.vhPsR9enmp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 23:28:38 Jassi Brar wrote:
> On 21 November 2014 22:45, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 21 November 2014 22:06:51 Jassi Brar wrote:
> 
> >> >> Only MB86S70_CRG11_UNGPRT is marked to mean one special (non-maskable)
> >> >> port on the controller, which the clock driver does make use of.
> >> >
> >> > Is this the actual port number that is known to be non-maskable?
> >> >
> >> Yes the clock comes out of the controller and is also the parent of
> >> other 8 independently maskable clock ports of the domain.
> >
> > I'm getting confused by the terminology here. Is MB86S70_CRG11_ALW
> > a port or a controller?
> >
> Sorry, bad symbols. ALW..DPHY are controllers. UNGPRT is the ninth
> parent clock (port) of a domain that can't be masked.
> FYKI, there are 6 instances, of some CRG11 clock controller, under
> control of the remote f/w. The Mailbox protocol between remote f/w and
> Linux assigned indices [0-5] to these controllers.

Ok, not it makes sense, thanks for clearing that up!

> >>  The firmware on remote master, lets say, don't wanna be bothered by
> >> the clock topology. Even for set-rate the onus is on Linux to request
> >> only appropriate rates at appropriate times so that other devices are
> >> not messed up.
> >
> > Is there any code to validate that, or does Linux just treat all
> > clocks transparently?
> >
> The remote does not expose the clock topology and only accepts
> requests on port-basis. The remote f/w is supposed to keep track of
> which ports are used by Linux and then work out inter-dependencies
> upon receiving a request from Linux. So for Linux there are N
> independent 'root' clocks, ops on which may or may not succeed at any
> given time.

Ok.

	Arnd
