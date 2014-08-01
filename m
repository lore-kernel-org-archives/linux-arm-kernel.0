From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 1 Aug 2014 10:40:04 +0200
Subject: [PATCH 8/8] clk: tegra: Add EMC clock driver
In-Reply-To: <20140731190659.4463.92139@quantum>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-9-git-send-email-mperttunen@nvidia.com>
 <53CE97F2.80300@wwwdotorg.org> <53D75FA7.1030300@nvidia.com>
 <20140729201939.4627.79710@quantum>
 <53D81CD4.5010307@wwwdotorg.org> <20140730093456.GA29590@ulmo>
 <20140731190659.4463.92139@quantum>
Message-ID: <20140801084003.GA21724@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 12:06:59PM -0700, Mike Turquette wrote:
> Quoting Thierry Reding (2014-07-30 02:34:57)
[...]
> > Not merging this feature upstream won't stop anybody from implementing
> > it as a hack in Android/product kernels either. If it's useful then
> > somebody will implement it in whatever downstream kernel they use. And
> > if it's useful to more than one vendor then we'll end up with a copy of
> > the implementation (and derivations on top) in each vendor's tree.
> 
> Thierry,
> 
> That argument is not sufficient to merit merging code. There is all
> kinds of wacky downstream code that gets duplicated by various hardware
> vendors, Linux distributions, the Cyanogenmod community, etc. Should we
> merge any piece of downstream code just because more than one person
> wants to use it?

Of course not. And that wasn't my point. My point was that if people
want to implement hacks as shortcuts and avoid the work involved in
doing things properly, then they will find ways to do so irrespective
of whether code can be merged upstream or not.

But we're talking about a debugfs interface here. It was designed to be
used to make life easier for *developers* and provide a way to make it
easier to debug problems. I've certainly been in a situation a couple of
times where I wished this kind of knob had been available to avoid
rebuilding the kernel and rebooting just to tune some clock frequency to
see if it would make things work.

> > debugfs requires superuser privileges anyway, in which case you could
> > equally well write userspace software that directly bangs on the clock
> > controller registers.
> 
> Sure. There are lots of technical reasons why this isn't such a bad idea
> (e.g. you need admin privileges, we shouldn't ship devices with debugfs
> turned on, etc). But by merging it we tell people, "hey, this is an OK
> thing to do", which it is not.

I disagree. What we'd be telling people is: "Here's a bunch of knobs
that you can use to play around with clock frequencies for *debugging*
purposes." Using debugfs is never an OK thing to do for production
software. But I don't think you'll prevent people from doing stupid
things by limiting what a debug interface can do. The only thing you'll
achieve is to make it more difficult for people who want to use it the
right way.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/e2d68350/attachment.sig>
