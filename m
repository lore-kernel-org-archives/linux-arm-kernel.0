From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 11:18:26 -0700
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <517184A2.9020908@ti.com>
References: <20130419171318.GK10155@atomide.com> <517181B2.9070302@ti.com>
 <20130419174454.GM10155@atomide.com> <517184A2.9020908@ti.com>
Message-ID: <20130419181825.GN10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 10:56]:
> On Friday 19 April 2013 11:14 PM, Tony Lindgren wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [130419 10:43]:
> >> On Friday 19 April 2013 10:43 PM, Tony Lindgren wrote:
> >>> Hi all,
> >>>
> >>> Here's a list of breakage I've noticed so far while trying to
> >>> use linux next on my pandaboard es. Probably similar issues exist
> >>> on other boards as well.
> >>>
> >>> Ideally we would not have any breakage by the merge window, so
> >>> let's try to get these fixed ASAP:
> >>>
> >>> 1. Serial console broken on panda es booting with DT
> >>>
> >>> The symptoms are dmesg output stopping after few lines
> >>> and only continuing after pressing a key. Does not seem to
> >>> happen on blaze with DT for some reason. And does not happen
> >>> on panda es with legacy booting.
> >>>
> >> This one is known and reported on list along with fix patches and
> >> later pull request [1].
> >>
> >> Unfortunately with all the testing and everything and patches have
> >> been on the list for quite some time, feedback on one of the patch
> >> received was after pull request and then there was no further
> >> clarification. That series address the same exact issue you have
> >> mentioned above.
> > 
> > OK thanks. I think Paul picked some of those and the plan was
> > to update the branch? Which one(s) should go into v3.10 as fixes?
> > 
> Main in that series was to handle driver sysc handling withing hwmod
> layer and that is where the series got stuck [2]. Without that support
> other patches won't fix the issue.

OK it seems that that is still ongoing discussion. For v3.10 we should
probably just disable PM for omap4 for DT booting so people can use
it for DT related development.

Regards,

Tony
 
> >> [1] http://patchwork.ozlabs.org/patch/229269/
> 
> [2] https://patchwork.kernel.org/patch/2166931/
> 
