From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 23:29:01 +0000
Subject: [PATCH] ARM: cache-v7: Disable preemption when reading CCSIDR
In-Reply-To: <4F398D61.9080501@codeaurora.org>
References: <alpine.LFD.2.02.1202022016480.2759@xanadu.home>
 <1328234629-32735-1-git-send-email-sboyd@codeaurora.org>
 <CAH+eYFCKcPzMMp_Ef5iX0Xp=xK8MdvJoUBRgKGT56SVjY5DXoA@mail.gmail.com>
 <alpine.LFD.2.02.1202131307430.24536@xanadu.home>
 <4F3952C7.3040502@codeaurora.org>
 <20120213181501.GD25655@n2100.arm.linux.org.uk>
 <4F398D61.9080501@codeaurora.org>
Message-ID: <20120213232901.GG25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 02:23:29PM -0800, Stephen Boyd wrote:
> On 02/13/12 10:15, Russell King - ARM Linux wrote:
> > On Mon, Feb 13, 2012 at 10:13:27AM -0800, Stephen Boyd wrote:
> >> Thanks. Russell has already merged the original patch to the fixes
> >> branch. Hopefully he can fold this one in.
> > Nope, I've asked Linus to pull it.
> >
> > So do we conclude that the original patch wasn't properly tested? :P
> 
> Sigh. Lockdep strikes again! I promise I tested it with lockdep disabled.
> 
> It looks like Linus' hasn't pulled yet but maybe he just hasn't
> published it.

It's not nice to change something after you've sent a pull request -
there's no way of knowing when Linus actually pulls it before he's
published it, and if he gets something different then it can raise
questions.

So, it's gone in as-is, and, as I'm now intending asking for another
pull request soo soon after my previous one, this is something that
we will have to live with probably for the remainder of the week.

Note that you should, by default, build your development kernels with
lockdep enabled, it's there as a debugging tool to help you find
logical locking errors faster than people can provoke deadlocks.
