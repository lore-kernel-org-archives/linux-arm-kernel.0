From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 May 2011 15:27:06 -0400 (EDT)
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <4DC2F6B0.80800@am.sony.com>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com> <4DC2E669.2000101@am.sony.com>
	<1304620350.2398.29.camel@i7.infradead.org>
	<4DC2EF19.5010309@am.sony.com>
	<alpine.LFD.2.00.1105051453280.24613@xanadu.home>
	<BANLkTimfKJPcDN+L4+z1DnsMv_BMOHpyew@mail.gmail.com>
	<4DC2F6B0.80800@am.sony.com>
Message-ID: <alpine.LFD.2.00.1105051518580.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 May 2011, Tim Bird wrote:

> On 05/05/2011 12:04 PM, Mike Frysinger wrote:
> > On Thu, May 5, 2011 at 14:54, Nicolas Pitre wrote:
> >> On Thu, 5 May 2011, Tim Bird wrote:
> >>> On 05/05/2011 11:32 AM, David Woodhouse wrote:
> >>>> On Thu, 2011-05-05 at 11:03 -0700, Tim Bird wrote:
> >>>>> On 05/05/2011 11:00 AM, Tim Bird wrote:
> >>>>>> On 05/05/2011 07:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>>>>> nearly no-one use it, only amop1, pxa and sa1100 implement it
> >>>>>>
> >>>>>> Sony uses this - a lot.  Principally we're using this on a NEC
> >>>>>> naviengine part, which is ARM11MPCore based, support for which
> >>>>>> is (sadly) out of tree.
> >>>>
> >>>> If you're out of tree, you don't exist.
> >>>
> >>> Yeah - I know.  I guess I should tell NEC we'll drop support
> >>> for their chip and move to another one that supports XIP
> >>> if they don't get their act together.  If XIP survives...
> >>
> >> It is easy enough to keep it alive... as long as someone uses it of
> >> course.
> > 
> > i think David's point:
> > ... someone <in tree> uses it ...
> 
> I should add that I tried to use XIP on omap (for research purposes),
> but it was broken and I didn't have time to fix it.  My bad.

OMAP is doing pretty nasty things with their early serial port support.  
This is most likely to screw up XIP.

> If anyone is using XIP on in-tree platforms, I'd like to hear
> about it.
> 
> As for in-tree-ness - I thought the most recent message was to stay
> out of tree until the refactoring was over. ;-)

Just to be clear... We have XIP in the tree already.  If it is useful 
to someone, in-tree or out-of-tree, then it is worth keeping around.  
Even if the only user was out-of-tree which certainly wasn't the case 
when I added XIP support to the kernel, then ripping it out and adding 
it back later would be more trouble than preserving it.

What I was asking recently is whether or not XIP is still useful to 
someone today.  Apparently it is, which is the answer I was looking for.


Nicolas
