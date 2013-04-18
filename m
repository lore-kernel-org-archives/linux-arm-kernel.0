From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 16:42:36 +0100
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
In-Reply-To: <517003CF.5090106@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <515C1F3B.5040008@linaro.org> <20130418141359.GT14496@n2100.arm.linux.org.uk>
 <517003CF.5090106@linaro.org>
Message-ID: <20130418154236.GY14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 04:31:43PM +0200, Daniel Lezcano wrote:
> On 04/18/2013 04:13 PM, Russell King - ARM Linux wrote:
> > On Wed, Apr 03, 2013 at 02:23:23PM +0200, Daniel Lezcano wrote:
> >> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> >>> The noop functions code is not necessary because the header file is
> >>> included in files which are compiled when CONFIG_CPU_IDLE is on.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> I have been involved in the development of this file. I know Rob is no
> >> longer working on this neither monitoring the code.
> >>
> >> Russell are you ok with this patch ? Rafael needs your ack to take this
> >> patch into its tree.
> > 
> > I don't know - the description doesn't make it clear.  Surely, what you
> > checked was that this file is _not_ included in any file which is built
> > when CONFIG_CPU_IDLE is disabled.  In other words, when CONFIG_CPU_IDLE
> > is not defined, arm_cpuidle_simple_enter() is never referenced.
> > 
> > If that is the case, then it's just that the patch description is the
> > opposite of what it should be for this patch - and then the patch and
> > description match and I don't see any reason to say no to it.
> > 
> > Then comes the issue of who takes the patch.  It looks like Rafael
> > would like me to.
> 
> Actually Rafael was willing to take the patch if you ack it.

Well, I want to see a proper description on the patch which describes
what it _is_ doing before I ack it.  The existing description is just
plain confusing.
