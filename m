From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 10:16:56 -0500
Subject: [PATCH 00/10] pinctrl: mvebu: remove hard-coded addresses from
 Dove pinctrl
In-Reply-To: <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
References: <1393231382-11078-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140224181023.GA1010@titan.lakedaemon.net>
 <CACRpkdZ+YGTyDj6i8c198MdRtz3GY-YBmVO9LysPCcmT4EC0cg@mail.gmail.com>
Message-ID: <20140225151656.GI1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 10:36:54AM +0100, Linus Walleij wrote:
> On Mon, Feb 24, 2014 at 7:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > Sebastian, Linus,
> >
> > I've now created mvebu/pinctrl-dove for this series.  It's based on
> > v3.14-rc1, and depends on mvebu/pinctrl (which depends on
> > mvebu/pinctrl-3xx).
> >
> > I've kept this series in a separate branch in case we encounter an
> > unforeseen problem with something in here.  Then this branch can be
> > dropped, and /pinctrl-3xx and /pinctrl will still make it in.
> >
> > So, all patches except 3 and 4 are in mvebu/pinctrl-dove.  3 and 4 are
> > in mvebu/dt.
> 
> OK so what should I be pulling in first now?

Of course I woke up this morning not happy with this :-/  Here's what it
looks like currently:

  /v3.14-rc1
  |
--+---+---+---+---+ mvebu/pinctrl-3xx
  |               \
  |---+---+---+---+---+---+---+ mvebu/pinctrl
  \                           \
   \---------------------------+---+---+---+ mvebu/pinctrl-dove

Not to scale.


I would prefer to do:

  /v3.14-rc1
  |
--+---+---+---+---+ mvebu/pinctrl-cleanup
  |               \
  |----------------+--+---+---+ mvebu/pinctrl-3xx
  \                \
   \----------------+---+---+--+---+---+---+ mvebu/pinctrl-dove

But this would mean moving some patches to branches other than what they
were sent with.  The advantage is that /pinctrl-3xx and /pinctrl-dove
don't depend on each other, and only depend on -cleanup.  Which is great
if there is something wrong in either branch.

Sebastian, I can cherry-pick the patches around, but you know the code
better than any of us, do you foresee any problems with this scenario?

thx,

Jason.
