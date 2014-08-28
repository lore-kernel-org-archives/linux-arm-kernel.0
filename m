From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Aug 2014 12:08:35 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
References: <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather> <20140827095241.GC23186@ulmo>
 <20140827154221.GX15297@lukather>
 <CAOMqctSY7AJKHthe+aG8--Ok6JiY1g2zM_tN10S2nELOSe=qMw@mail.gmail.com>
Message-ID: <20140828100834.GA14388@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:57:29PM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 27 August 2014 17:42, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Aug 27, 2014 at 11:52:48AM +0200, Thierry Reding wrote:
> >> On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> >> > On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> >> > > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> >> > > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
> >> [...]
> >> > > > > > Mike Turquette repeatedly said that he was against such a DT property:
> >> > > > > > https://lkml.org/lkml/2014/5/12/693
> >> > > > >
> >> > > > > Mike says in that email that he's opposing the addition of a property
> >> > > > > for clocks that is the equivalent of regulator-always-on. That's not
> >> > > > > what this is about. If at all it'd be a property to mark a clock that
> >> > > > > should not be disabled by default because it's essential.
> >> > > >
> >> > > > It's just semantic. How is "a clock that should not be disabled by
> >> > > > default because it's essential" not a clock that stays always on?
> >> > >
> >> > > Because a clock that should not be disabled by default can be turned off
> >> > > when appropriate. A clock that is always on can't be turned off.
> >> >
> >> > If a clock is essential, then it should never be disabled. Or we don't
> >> > share the same meaning of essential.
> >>
> >> Essential for the particular use-case.
> >
> > So, how would the clock driver would know about which use case we're
> > in? How would it know about which display engine is currently running?
> > How would it know about which video output is being set?
> >
> > Currently, we have two separate display engines, which can each output
> > either to 4 different outputs (HDMI, RGB/LVDS, 2 DSI). Each and every
> > one of these combinations would require different clocks. What clocks
> > will we put in the driver? All of them?
> >
> 
> since simplefb cannot be extended how about adding, say, dtfb which
> claims the resources from dt and then instantiates a simplefb once the
> resources are claimed? That is have a dtfb which has the clocks
> assigned and has simplefb as child dt node.

I don't see how that changes anything. All you do is add another layer
of indirection. The fundamental problem remains the same and isn't
solved.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140828/f3eec559/attachment-0001.sig>
