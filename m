From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 13:22:59 +0000
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <20150326123028.GM4701@suse.de>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk>
 <20150326123028.GM4701@suse.de>
Message-ID: <20150326132258.GH8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 12:30:29PM +0000, Mel Gorman wrote:
> On Thu, Mar 26, 2015 at 11:46:12AM +0000, Russell King - ARM Linux wrote:
> > <SNIP>
> > 
> > Looking at Mel's commit, I don't see a reason why we couldn't use that
> > solution - it gets rid of walking the page array, which has been fraught
> > in the past due to ARM having platforms which have holes in their
> > physical memory.
> > 
> > We could try that solution - I don't see much downside to it.  Most of
> > that information is as debug information for MM stuff anyway, and IMHO
> 
> >From an MM perspective, I can tell you that the information is close to
> useless for debugging anything. It's why I ditched it in that commit and
> AFAIK, no one has ever cared.

In that case, is there much point to show_mem()?  Is it something which
should be considered for removal?

If code serves no useful purpose anymore, we really ought to have a way
to remove it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
