From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 10:43:47 -0500
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <530CB725.5070904@gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
 <20140225151656.GI1010@titan.lakedaemon.net>
 <530CB725.5070904@gmail.com>
Message-ID: <20140225154347.GJ1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 04:30:45PM +0100, Sebastian Hesselbarth wrote:
> On 02/25/14 16:16, Jason Cooper wrote:
> >On Tue, Feb 25, 2014 at 10:36:54AM +0100, Linus Walleij wrote:
> >>On Mon, Feb 24, 2014 at 7:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> >>>I've now created mvebu/pinctrl-dove for this series.  It's based on
> >>>v3.14-rc1, and depends on mvebu/pinctrl (which depends on
> >>>mvebu/pinctrl-3xx).
> >>>
> >>>I've kept this series in a separate branch in case we encounter an
> >>>unforeseen problem with something in here.  Then this branch can be
> >>>dropped, and /pinctrl-3xx and /pinctrl will still make it in.
> >>>
> >>>So, all patches except 3 and 4 are in mvebu/pinctrl-dove.  3 and 4 are
> >>>in mvebu/dt.
> >>
> >>OK so what should I be pulling in first now?
> >
> >Of course I woke up this morning not happy with this :-/  Here's what it
> >looks like currently:
> >
> >   /v3.14-rc1
> >   |
> >--+---+---+---+---+ mvebu/pinctrl-3xx
> >   |               \
> >   |---+---+---+---+---+---+---+ mvebu/pinctrl
> >   \                           \
> >    \---------------------------+---+---+---+ mvebu/pinctrl-dove
> >
> >Not to scale.
> >
> >
> >I would prefer to do:
> >
> >   /v3.14-rc1
> >   |
> >--+---+---+---+---+ mvebu/pinctrl-cleanup
> >   |               \
> >   |----------------+--+---+---+ mvebu/pinctrl-3xx
> >   \                \
> >    \----------------+---+---+--+---+---+---+ mvebu/pinctrl-dove
> >
> >But this would mean moving some patches to branches other than what they
> >were sent with.  The advantage is that /pinctrl-3xx and /pinctrl-dove
> >don't depend on each other, and only depend on -cleanup.  Which is great
> >if there is something wrong in either branch.
> >
> >Sebastian, I can cherry-pick the patches around, but you know the code
> >better than any of us, do you foresee any problems with this scenario?
> 
> If Thomas agrees, I can rework Armada 375/38x pinctrl stubs to fit on
> mvebu/pinctrl. That should allow you to have mvebu/pinctrl-dove
> independent of mvebu/pinctrl-3xx.
> 
> Not a big deal, I'd just pick 375/38x patches from mvebu/pinctrl and
> squash them into mvebu/pinctrl-3xx. The only "issue" is that DT
> documentation update patches from mvebu/pinctrl-dove have to be split
> too.
> 
> I'll prepare the three new branches for you and Thomas to look at
> today.

Ok, great.  Thanks Sebastian!

thx,

Jason.
