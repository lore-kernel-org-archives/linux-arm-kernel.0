From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Jul 2013 16:51:33 -0400
Subject: [GIT PULL] ARM: mvebu: stable fix for v3.10
In-Reply-To: <CAOesGMjNh3u=GmckBHfTZtJSEzbwPHtkJkhC7kCwFQ+TeKtHAA@mail.gmail.com>
References: <20130725173357.GN23879@titan.lakedaemon.net>
 <CAOesGMjNh3u=GmckBHfTZtJSEzbwPHtkJkhC7kCwFQ+TeKtHAA@mail.gmail.com>
Message-ID: <20130725205133.GY23879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 01:33:08PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, Jul 25, 2013 at 10:33 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Arnd, Olof,
> >
> > I'm trying something new.  I've based this branch off of the common
> > ancestor to the v3.10.x tree (v3.10).  If you could handle it just like
> > a normal mvebu/fixes branch (ie merge it in for v3.11-rcX), once it hits
> > mainline, I'll send a PR to the stable folks for the branch.
> >
> > The advantage of this is that you get the same commit id in both trees
> > and it's less work for the stable maintainers.
> >
> > Also, please note the URL change.  I'll post an announcement about that
> > shortly.
> >
> > As usual, please tell me if I'm all fouled up. :)
> 
> I'm confused. Just to double-check, I just checked out v3.10 and built
> orion5x_defconfig, without any kind of problem.

gah! you're right.  I did a git blame on the mbus call to see how far
back to go, but didn't look deep enough.  mv643xx_eth.h includes mbus.h.

The error occurs once mv643xx_eth.h is removed (in Sebastian's patch
series to convert mv643xx_eth init to DT).  I'll append this patch to
the series causing the build failure.  Please ignore this PR.

Sorry for the noise.

thx,

Jason.
